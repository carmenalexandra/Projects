create table photos(
id_poza NUMBER constraint id_poza_pk primary key, 
descriere VARCHAR2(255), 
img ORDIMAGE, 
img_semn ORDImageSignature);

create or replace procedure afisareimg (vid in number, flux out BLOB)
is
obj ORDImage;
begin
select img into obj from photos where id_poza = vid;
flux:= obj.getcontent();
end;

create or replace procedure proc_ins (v_id in number, v_descriere in varchar2, fis in BLOB) 
as
begin
insert into photos values (v_id, v_descriere, ORDImage(fis, 1), ORDImageSignature.init());
commit;
end;

create or replace procedure psgensemn
is
mysig ORDImageSignature;
myimg ORDImage;
begin
for x in (select id_poza from photos)
loop
    select P.img, P.img_semn into myimg, mysig from photos P where P.id_poza = x.id_poza for update;
    mysig.generatesignature(myimg);
    update photos P 
    set P.img_semn = mysig where P.id_poza = x.id_poza;
end loop;
end;

create or replace procedure psregasire (fis in BLOB, cculoare in decimal, ctextura in decimal, cforma in decimal, clocatie in decimal, idrez out integer)
is
scor NUMBER;
myimg ORDImage;
mysemn ORDImageSignature;
qimg ORDImage;
qsemn ORDImageSignature;
mymin NUMBER;
begin
qimg:= ORDImage(fis, 1);
qimg.setproperties;
qsemn:= ORDImageSignature.init();
DBMS_LOB.CREATETEMPORARY(qsemn.signature, TRUE);
qsemn.generateSignature(qimg);
mymin:= 100;
for x in (select id_poza from photos)
loop
    select P.img_semn into mysemn from photos P where P.id_poza = x.id_poza;
    scor:= ORDImageSignature.evaluateScore(qsemn, mysemn, 'color = ' || cculoare || 'texture = ' || ctextura || 'shape = ' || cforma || 'location = ' || clocatie || '');
    if scor < mymin then 
        mymin:= scor;
        idrez:= x.id_poza;
        end if;
end loop;
end;




