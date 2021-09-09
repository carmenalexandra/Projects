CREATE TABLE utilizatori (
id_utilizator NUMBER(8) CONSTRAINT id_utilizator_pk PRIMARY KEY,
nume VARCHAR2(40),
prenume VARCHAR2(40),
email VARCHAR2(50) UNIQUE,
telefon VARCHAR2(11) UNIQUE,
data_inregistrarii DATE);

CREATE TABLE abonamente (
id_abonament NUMBER(10) CONSTRAINT id_abonament_pk PRIMARY KEY,
tip_abonament VARCHAR2(10),
modalitate_plata VARCHAR2(12),
perioada_testare VARCHAR2(6));

CREATE TABLE detalii_abonament (
id_utilizator REFERENCES utilizatori(id_utilizator),
id_abonament REFERENCES abonamente(id_abonament),
pret NUMBER(3,2),
nr_dispozitive NUMBER(4));

CREATE TABLE recomandari (
preferinte_util NUMBER(15) CONSTRAINT preferinte_util_pk PRIMARY KEY,
populare VARCHAR2(150),
originale_netflix VARCHAR2(150),
top_10_ro VARCHAR(150),
trending VARCHAR2(150),
noutati VARCHAR2(150));

CREATE TABLE filme (
nume_film VARCHAR2(50) CONSTRAINT nume_film_pk PRIMARY KEY,
data_aparitie_f DATE,
gen_film VARCHAR2(40),
durata NUMBER(4),
rating_f NUMBER(3,3),
preferinte_util NUMBER(15),
CONSTRAINT preferinte_util_fk1 FOREIGN KEY (preferinte_util) REFERENCES recomandari(preferinte_util));

CREATE TABLE filme_pt_utilizatori (
id_utilizator NUMBER(8) REFERENCES utilizatori(id_utilizator),
nume_film VARCHAR2(50) REFERENCES filme(nume_film),
nr_vizualizari_f NUMBER(9),
descriere_f VARCHAR2(80),
potrivire_f NUMBER(4,2));

CREATE TABLE seriale (
nume_serial VARCHAR2(50) CONSTRAINT nume_serial_pk PRIMARY KEY,
data_aparitie_s DATE,
gen_serial VARCHAR2(40),
nr_sezoane NUMBER(3),
durata_medie_episod NUMBER(4),
rating_s NUMBER(3,3),
preferinte_util NUMBER(15),
CONSTRAINT preferinte_util_fk2 FOREIGN KEY (preferinte_util) REFERENCES recomandari(preferinte_util));

CREATE TABLE seriale_pt_utilizatori (
id_utilizator NUMBER(8) REFERENCES utilizatori(id_utilizator),
nume_serial VARCHAR2(50) REFERENCES seriale(nume_serial),
nr_vizualizari_s NUMBER(9),
descriere_s VARCHAR2(80),
potrivire_s NUMBER(4,2));


ALTER TABLE detalii_abonament MODIFY (pret NUMBER(5,3));
ALTER TABLE filme MODIFY (rating_f NUMBER(3,2)); 
ALTER TABLE seriale MODIFY (rating_s NUMBER(3,2));
ALTER TABLE filme_pt_utilizatori MODIFY (descriere_f VARCHAR2(200));
ALTER TABLE seriale_pt_utilizatori MODIFY (descriere_s VARCHAR2(300));


INSERT INTO utilizatori VALUES (1, 'Marin', 'Anda', 'marin.anda@gmail.com', '0765187920', TO_DATE('01.03.2018', 'dd.mm.yyyy'));            /* 1.basic 111 */
INSERT INTO utilizatori VALUES (2, 'Anghel', 'Ana-Maria', 'anghel.anam@gmail.com', '0749815007', TO_DATE('21.07.2019', 'dd.mm.yyyy'));     /* 2.premium 441 */
INSERT INTO utilizatori VALUES (3, 'Valeriu', 'Paul', 'valeriu.paul@gmail.com', '0727945061', TO_DATE('14.10.2019', 'dd.mm.yyyy'));        /* 3,.standard 221 */
INSERT INTO utilizatori VALUES (4, 'Stroia', 'Iulian', 'stroia.iulian@gmail.com', '0764785124', TO_DATE('22.09.2020', 'dd.mm.yyyy'));      /* 4.basic 112 */
INSERT INTO utilizatori VALUES (5, 'Chirita', 'Octavian', 'chirita.octav@gmail.com', '0797844576', TO_DATE('11.02.2020', 'dd.mm.yyyy'));   /* 5.premium 442 */
INSERT INTO utilizatori VALUES (6, 'Ene', 'Maria', 'ene.maria@gmail.com', '0734587692', TO_DATE('19.04.2019', 'dd.mm.yyyy'));              /* 6.basic 113 */
INSERT INTO utilizatori VALUES (7, 'Rotaru', 'Lavinia', 'rotaru.lavinia@gmail.com', '0745971206', TO_DATE('05.05.2020', 'dd.mm.yyyy'));    /* 7.basic 114 */
INSERT INTO utilizatori VALUES (8, 'Mihai', 'Gabriela', 'mihai.gabriela@gmail.com', '0778128451', TO_DATE('30.12.2018', 'dd.mm.yyyy'));    /* 8.standard 222 */
INSERT INTO utilizatori VALUES (9, 'Lorelai', 'Ancuta', 'lore.ancuta@gmail.com', '0725486137', TO_DATE('25.11.2018', 'dd.mm.yyyy'));       /* 9.standard 223 */
INSERT INTO utilizatori VALUES (10, 'Ionita', 'Radu', 'ionita.radu@gmail.com', '0736541809', TO_DATE('06.06.2020', 'dd.mm.yyyy'));         /* 10.premium 443 */

INSERT INTO abonamente VALUES (111, 'Basic', 'card', 'o luna');
INSERT INTO abonamente VALUES (112, 'Basic', 'card', '-');
INSERT INTO abonamente VALUES (113, 'Basic', 'card', 'o luna');
INSERT INTO abonamente VALUES (114, 'Basic', 'card', '-');
INSERT INTO abonamente VALUES (221, 'Standard', 'card', 'o luna');
INSERT INTO abonamente VALUES (222, 'Standard', 'card', 'o luna');
INSERT INTO abonamente VALUES (223, 'Standard', 'card', 'o luna');
INSERT INTO abonamente VALUES (441, 'Premium', 'card', 'o luna');
INSERT INTO abonamente VALUES (442, 'Premium', 'card', '-');
INSERT INTO abonamente VALUES (443, 'Premium', 'card', '-');

INSERT INTO detalii_abonament VALUES (1, 111, '7.99', '1');
INSERT INTO detalii_abonament VALUES (2, 441, '11.99', '4');
INSERT INTO detalii_abonament VALUES (3, 221, '9.99', '2');
INSERT INTO detalii_abonament VALUES (4, 112, '7.99', '1');
INSERT INTO detalii_abonament VALUES (5, 442, '11.99', '4');
INSERT INTO detalii_abonament VALUES (6, 113, '7.99', '1');
INSERT INTO detalii_abonament VALUES (7, 114, '7.99', '1');
INSERT INTO detalii_abonament VALUES (8, 222, '9.99', '2');
INSERT INTO detalii_abonament VALUES (9, 223, '9.99', '2');
INSERT INTO detalii_abonament VALUES (10, 443, '11.99', '4');

INSERT INTO recomandari VALUES (941658, 'Vikings, Sherlock, The Haunting of Hill House, Prison Break, BLACKLIST', 'MINDHUNTER, SHADOW HUNTERS, The Witcher, The Alienist', 'The Haunting of Bly House, The Umbrella Academy, DARK, Ratched, Black Mirror', 'The Walking Dead, Rick and Morty, sense8, Narcos', 'Breaking Bad, Divergent, Unsolved misteries, Peaky Blinders, THE 100');
INSERT INTO recomandari VALUES (521467, 'YOU, Dinasty, Once Upon A Time, Insatiable, Marriage Story', 'Dead To Me, Emily In Paris, Sabrina, 13 Reasons Why', 'The Crown, Before I go to sleep, The princess switch, trust, Papillon', 'The Notebook, Gossip Girl, Dark desire, Grace and Frankie', 'Valeria, Riverdale, Rebecca, The Order, After');
INSERT INTO recomandari VALUES (348102, 'HOLIDATE, HUSTLERS, Monster-in-law, Gilmore Girls, SUITS', 'Tall Girl, The Good Place, The Kissing Booth 2, Never Have I Ever', 'Emily In Paris, Dash and Lily, Sex Education, Derry Girls, YOU ME HER', 'glee, Friends With Benefits, The Big Bang Theory, FRIENDS', 'Atypical, Crazy Stupid Love, How I Met Your Mother, Shameless'); 
INSERT INTO recomandari VALUES (789721, 'ELITE, La Casa De Papel, TOY BOY, Zodiac, Before I Go To Sleep', 'Bird Box, Rebecca, Narcos Mexico, Ratched', 'Altered Carbon, The Devil All The Time, Americand Psicho, Secret Obsession, How To Get Away With Murder', 'YOU, Locked Up, MINDHUNTER, Papillon', 'Arkansas, Pretty Little Liars, Prison Break, The Witcher');
INSERT INTO recomandari VALUES (216837, 'the social dilemma, The Secret, Making a Murderer, Our Planet, Hip-Hop Evolution', 'Dark Tourist, Unsolved misteries, Abducted in plain sight, American Murder', 'This is it, The truth about alcohol, Flavours of Romania, The Story of Diana, Ted Bundy tapes', 'I am a killer, Love on the spectrum, Three identical strangers, Unsolved', '100 days of solitude,Pablo Escobar countdown to death, Evil Genius, The confession tapes');
INSERT INTO recomandari VALUES (149726, 'Dear John, A Star Is Born, The Best of Me, EAT PRAY LOVE', 'To all the boys I ve loved before, To all the boys I ve loved before 2, a secret love, A fortunate man', 'Rebecca, The Queen s Gambit, The Crown, All The Bright Places, Midnight Sun', 'The great Gatsby, what we wanted, 13 Reasons Why, The girl on the train', 'Pride and Prejudice, 1922,The lucky one, After');

INSERT INTO filme VALUES ('Divergent', TO_DATE('21.03.2014', 'dd.mm.yyyy'), 'actiune', 139, 8.1, 941658);                      /* actiune/politist, horror/crime tv drama: cod 941658 */
INSERT INTO filme VALUES ('Marriage Story', TO_DATE('15.11.2019', 'dd.mm.yyyy'), 'drama romantica', 137, 8, 521467);           /* drama si romantism: cod 521467 */
INSERT INTO filme VALUES ('Crazy Stupid Love', TO_DATE('19.07.2011', 'dd.mm.yyyy'), 'comedie romantica', 140, 7.8, 348102);    /* comedie si romantism: cod 348102*/
INSERT INTO filme VALUES ('Zodiac', TO_DATE('08.06.2007', 'dd.mm.yyyy'), 'thriller', 162, 7.7, 789721);                        /* thriller si mister: cod 789721 */
INSERT INTO filme VALUES ('the social dilemma', TO_DATE('26.01.2020', 'dd.mm.yyyy'), 'documentar', 94, 7.7, 216837);           /* documentar si docuseries: cod 216837 */
INSERT INTO filme VALUES ('All The Bright Places', TO_DATE('28.02.2020', 'dd.mm.yyyy'), 'romantic', 108, 6.5, 149726);        /* romantism/drama si based on books/real life: cod 149726 */
INSERT INTO filme VALUES ('Bird Box', TO_DATE('14.12.2018', 'dd.mm.yyyy'), 'thriller', 124, 6.6, 789721);
INSERT INTO filme VALUES ('Dear John', TO_DATE('24.01.2010', 'dd.mm.yyyy'), 'drama romantica', 108, 8.2, 149726);
INSERT INTO filme VALUES ('The Secret', TO_DATE('13.09.2007', 'dd.mm.yyyy'), 'documentar',  91, 6.4, 216837);
INSERT INTO filme VALUES ('A Star Is Born', TO_DATE('03.10.2018', 'dd.mm.yyyy'), 'based on real life', 135, 8, 149726);
INSERT INTO filme VALUES ('trust', TO_DATE('01.04.2011', 'dd.mm.yyyy'), 'drama', 105, 6.9, 521467);
INSERT INTO filme VALUES ('Rebecca', TO_DATE('16.10.2020', 'dd.mm.yyyy'), 'mister', 121, 6, 789721);
INSERT INTO filme VALUES ('Midnight Sun', TO_DATE('22.03.2018', 'dd.mm.yyyy'), 'romantic-based on book', 104, 6.6, 149726); 
INSERT INTO filme VALUES ('The Devil All The Time', TO_DATE('11.09.2020', 'dd.mm.yyyy'), 'thriller psihologic', 138, 7.1, 789721);
INSERT INTO filme VALUES ('The great Gatsby', TO_DATE('17.05.2013', 'dd.mm.yyyy'), 'drama-based on book', 143, 7.2, 149726);

INSERT INTO filme_pt_utilizatori VALUES (1, 'Crazy Stupid Love', 2, 'cand afla ca sotia lui vrea sa divorteze, cal se confrunta cu reticenta asupra vietii singure, urmand sfatul unui tanar burlac', 91);
INSERT INTO filme_pt_utilizatori VALUES (2, 'The great Gatsby', 1, 'fascinat de misteriosul si bogatul Jay Gatsby, vecinul sau Nick Carraway este martor la decaderea acestuia din cauza unei iubiri obsesive', 89);
INSERT INTO filme_pt_utilizatori VALUES (3, 'Zodiac', 1, 'un caricaturist politic, un reporter criminalist si o pereche de politisti investigheaza infamul ucigas Zodiac din San Francisco in acest thriller bazat pe o poveste adevarata', 65);
INSERT INTO filme_pt_utilizatori VALUES (4, 'Bird Box', 2, 'la 5 ani dupa ce o prezenta nevazuta conduce majoritatea societatii sa comita suicid, o supravietuitoare si cei 2 copii ai sai incearca, cu disperare, sa ajunga intr-un loc sigur', 67);
INSERT INTO filme_pt_utilizatori VALUES (5, 'The Secret', 1, 'o adunare de scriitori, filosofi si oameni de stiinta impartasesc Secretul, care le-a adus reputatia lui Platon, daVinci si alti mareti', 73);
INSERT INTO filme_pt_utilizatori VALUES (6, 'Marriage Story', 1, 'Noah Baumbach, regizorul nominalizat la premiul Oscar, regizeaza aceasta perspectiva incisiva si plina de compasiune asupra unei casnicii care se destrama si a unei familii care ramane impreuna', 68);
INSERT INTO filme_pt_utilizatori VALUES (7, 'the social dilemma', 1, 'acest documentar dramatic exploreaza impactul periculos al retelelor sociale, cu experti in tehnologie care trag un semnal de alarma asupra propriei creatii', 94); 
INSERT INTO filme_pt_utilizatori VALUES (8, 'All The Bright Places', 2, 'doi adolescenti ce se confrunta cu probleme personale si formeaza o legatura puternica, in timp ce se avanta intr-o calatorie fenomenala, strabat minunile inconjuratoare ale Indianei', 83);
INSERT INTO filme_pt_utilizatori VALUES (9, 'Rebecca', 1, 'o tanara proaspat casatorita se muta in impunatoarea mosie a sotului ei, unde trebuie sa se lupte cu sinistra sa menajera si cu umbra bantuitoare a regretatei sale sotii', 94); 
INSERT INTO filme_pt_utilizatori VALUES (10, 'Divergent', 1, 'intr-o lume distrusa de razboi, Tris isi descopera abilitatile speciale si formeaza o echipa cu Four pentru a rezista unui complot sinistru pus la cale cu scopul de a-i distruge pe cei ca ei', 91);

INSERT INTO seriale VALUES ('MINDHUNTER', TO_DATE('13.10.2017', 'dd.mm.yyyy'), 'crime tv drama', 2, 50, 8.3, 941658);
INSERT INTO seriale VALUES ('ELITE', TO_DATE('05.10.2018', 'dd.mm.yyyy'), 'mister', 3, 45, 8.8, 789721);
INSERT INTO seriale VALUES ('Gossip Girl', TO_DATE('19.09.2007', 'dd.mm.yyyy'), 'drama', 6, 40, 8.8, 521467);
INSERT INTO seriale VALUES ('YOU', TO_DATE('09.09.2018', 'dd.mm.yyyy'), 'thriller psihologic', 2, 45, 8.2, 789721);
INSERT INTO seriale VALUES ('The Good Place', TO_DATE('19.09.2016', 'dd.mm.yyyy'), 'comedie', 4, 22, 8.2, 348102);
INSERT INTO seriale VALUES ('Ted Bundy tapes', TO_DATE('24.01.2019', 'dd.mm.yyyy'), 'docuseries', 1, 55, 7.8, 216837);
INSERT INTO seriale VALUES ('Narcos', TO_DATE('28.08.2015', 'dd.mm.yyyy'), 'politist', 3, 50, 8.8, 941658);
INSERT INTO seriale VALUES ('Sex Education', TO_DATE('11.01.2019', 'dd.mm.yyyy'), 'comedie-drama', 2, 45, 8.3, 348102);
INSERT INTO seriale VALUES ('The Queen s Gambit', TO_DATE('23.10.2020', 'dd.mm.yyyy'), 'drama-based on book', 1, 56, 8.8, 149726);
INSERT INTO seriale VALUES ('13 Reasons Why', TO_DATE('31.03.2017', 'dd.mm.yyyy'), 'drama-mister', 4, 60, 7.6, 521467);
INSERT INTO seriale VALUES ('The Big Bang Theory', TO_DATE('24.09.2007', 'dd.mm.yyyy'), 'sitcom', 12, 22, 8.1, 348102);
INSERT INTO seriale VALUES ('Unsolved', TO_DATE('27.02.2018', 'dd.mm.yyyy'), 'docuseries', 1, 50, 7.9, 216837);
INSERT INTO seriale VALUES ('The Haunting of Hill House', TO_DATE('12.10.2018', 'dd.mm.yyyy'), 'horror', 1, 60, 8.6, 941658);
INSERT INTO seriale VALUES ('The Crown', TO_DATE('04.11.2016', 'dd.mm.yyyy'), 'based on real life', 4, 55, 9, 149726);

INSERT INTO seriale_pt_utilizatori VALUES (1, 'The Big Bang Theory', 2, 'cand o fata draguta pe nume Penny se muta vis-a-vis de el, Leonard, un om de stiinta stanjenit, in mod obisnuit, din punct de vedere social, se indragosteste de ea pe loc, spre disperarea colegului sau de apartament, Sheldon', 95);
INSERT INTO seriale_pt_utilizatori VALUES (2, 'ELITE', 1, 'dupa ce un liceu public se prabuseste, constructorul incearca sa-si repare imaginea, platind ca 3 elevi afectati sa urmeze o scoala exclusiv privata', 89); 
INSERT INTO seriale_pt_utilizatori VALUES (3, 'Unsolved', 1, 'urmareste o versiune dramatizata a investigatiilor reale legate de uciderile unicilor raperi Tupac Shakur si Biggie Smalls', 79);
INSERT INTO seriale_pt_utilizatori VALUES (4, 'Narcos', 3, 'adevarata poveste a infamului violent si periculos cartel al drogurilor din Columbia alimenteaza aceste drame ale gangsterilor', 91);
INSERT INTO seriale_pt_utilizatori VALUES (5, 'The Haunting of Hill House', 1, 'prinsa intre trecut si prezent, o familie destramata se confrunta cu amintiri infricosatoare din vechea lor casa si evenimentele care i-au facut sa plece din ea', 98);
INSERT INTO seriale_pt_utilizatori VALUES (6, 'YOU', 1, 'un tanar mult prea fermecator, predominat de obsesii intense, recurge la masuri extreme pentru a se insera in viata celor de care este atras', 97);
INSERT INTO seriale_pt_utilizatori VALUES (7, 'Gossip Girl', 2, 'adolescentii privilegiati ai scolii de pregatire din Upper East Side, Manhattan, afla ca Serena van der Woodsen s-a intors', 70);
INSERT INTO seriale_pt_utilizatori VALUES (8, 'The Good Place', 1, 'cand Eleanor moare si ajunge intr-un paradis al vietii de apoi rezervat doar celor mai etici oameni, isi da seama ca a fost confundata cu altcineva', 87);
INSERT INTO seriale_pt_utilizatori VALUES (9, 'The Queen s Gambit', 1, 'intr-un orfelinat din anii 1950, o tanara fata dezvaluie un talent uimitor la sah si incepe o calatorie neobisnuita pentru a deveni cunoscuta, in timp ce se lupta cu dependenta', 98); 
INSERT INTO seriale_pt_utilizatori VALUES (10, 'MINDHUNTER', 2, 'la sfarsitul anilor 1970, doi agenti FBI extind stiinta criminala, adancindu-se in psihologia crimelor si apropiindu-se neplacut de mult de monstrii reali', 94);


UPDATE utilizatori SET nume = 'Marin' WHERE id_utilizator = 8;
SELECT * FROM utilizatori WHERE id_utilizator = 8;

UPDATE abonamente SET tip_abonament = 'Standard' WHERE id_abonament = 114;
SELECT * FROM abonamente WHERE id_abonament = 114;

UPDATE detalii_abonament SET pret = 9.99 WHERE id_abonament = 114;
UPDATE detalii_abonament SET nr_dispozitive = 2 WHERE id_abonament = 114;
SELECT * FROM detalii_abonament WHERE id_abonament = 114;

UPDATE seriale SET rating_s = (SELECT rating_s FROM seriale WHERE nume_serial = 'The Good Place') WHERE nume_serial = 'Sex Education';
SELECT * FROM seriale WHERE nume_serial IN ('The Good Place', 'Sex Education');

UPDATE filme_pt_utilizatori SET potrivire_f = potrivire_f + 5 WHERE potrivire_f BETWEEN 60 AND 75;

UPDATE filme SET gen_film = 'SF-actiune' WHERE nume_film = 'Divergent';
SELECT * FROM filme WHERE nume_film = 'Divergent';


DROP TABLE recomandari CASCADE CONSTRAINTS;


FLASHBACK TABLE recomandari TO BEFORE DROP;


SELECT * FROM filme WHERE durata BETWEEN 90 AND 170
MINUS
SELECT * FROM filme WHERE durata BETWEEN 130 AND 150;

SELECT * FROM seriale WHERE nr_sezoane BETWEEN 1 AND 12
MINUS
SELECT * FROM seriale WHERE nr_sezoane BETWEEN 4 AND 12;


SELECT id_utilizator, nume_film, nr_vizualizari_f,
CASE WHEN nr_vizualizari_f = 1 THEN 70
WHEN nr_vizualizari_f = 2 THEN 85
WHEN nr_vizualizari_f >= 3 THEN 100
ELSE 0
END grad_satisfacere_util
FROM filme_pt_utilizatori;

SELECT id_utilizator, nume_serial, nr_vizualizari_s,
CASE WHEN nr_vizualizari_s = 1 THEN 80
WHEN nr_vizualizari_s = 2 THEN 93
WHEN nr_vizualizari_s >= 3 THEN 100
ELSE 0
END grad_satisfacere_util
FROM seriale_pt_utilizatori;


SELECT id_abonament, tip_abonament, DECODE(tip_abonament, 'Basic', 0.05, 'Standard', 0.08, 'Premium', 0.1, 0) AS reducere_aplicata FROM abonamente;


SELECT nume, prenume, length(nume) AS lungime_nume, length(prenume) AS lungime_prenume FROM utilizatori;

SELECT * FROM utilizatori WHERE SUBSTR(email, 5, 1) IN ('e', 'i');

SELECT nume_serial || ' ' || gen_serial || ' ' || rating_s AS informatii_serial FROM seriale;

SELECT CONCAT(email, telefon) AS informatii_utilizator FROM utilizatori;

SELECT upper(originale_netflix) AS ORIGINALE_NETFLIX, lower(trending) AS trending FROM recomandari WHERE preferinte_util IN (789721, 941658);


SELECT ROUND(AVG(rating_f), 1) AS valoare_medie_rotunjita FROM filme;

SELECT nume_serial, TRUNC(rating_s) AS rating_rotunjit FROM seriale;


SELECT id_utilizator, data_inregistrarii FROM utilizatori WHERE EXTRACT (YEAR FROM data_inregistrarii) = 2020;

SELECT nume_film, data_aparitie_f FROM filme WHERE EXTRACT (MONTH FROM data_aparitie_f) IN (3,10) AND EXTRACT (YEAR FROM data_aparitie_f) = 2018;

SELECT nume_serial, data_aparitie_s FROM seriale WHERE EXTRACT (MONTH FROM data_aparitie_s) IN (1,9) AND EXTRACT (DAY FROM data_aparitie_s) BETWEEN 10 AND 20;

SELECT id_utilizator, ROUND(months_between(sysdate, data_inregistrarii)) AS luni FROM utilizatori;

SELECT id_utilizator, ROUND((sysdate - data_inregistrarii)) AS zile FROM utilizatori;

SELECT nume_serial, data_aparitie_s 
FROM seriale
WHERE data_aparitie_s BETWEEN TO_DATE('01.01.2015', 'dd.mm.yyyy') AND TO_DATE('31.12.2017', 'dd.mm.yyyy');


SELECT MIN(pret) AS valoare_minima, MAX(pret) AS valoare_maxima FROM detalii_abonament;

SELECT SUM(pret * 12) AS valoare_totala FROM detalii_abonament WHERE id_abonament = 441;

SELECT AVG(rating_f) AS valoare_medie FROM filme;

SELECT COUNT(nume_film) AS nr_filme FROM filme WHERE preferinte_util = 149726;

SELECT COUNT(nume_serial) AS nr_seriale FROM seriale WHERE nr_sezoane = 2;


SELECT u.nume, u.prenume, u.data_inregistrarii, f.nume_film 
FROM utilizatori u, filme_pt_utilizatori f
WHERE u.id_utilizator = f.id_utilizator
AND EXTRACT (YEAR FROM u.data_inregistrarii) = 2019;

SELECT u.nume, u.prenume, s.nume_serial, s.potrivire_s
FROM utilizatori u, seriale_pt_utilizatori s
WHERE u.id_utilizator = s.id_utilizator
AND s.potrivire_s BETWEEN 85 AND 95;

SELECT f.nume_film, length(f.nume_film) AS lungime_nume_film, s.nume_serial, length(s.nume_serial) AS lungime_nume_serial, NULLIF(length(f.nume_film), length(s.nume_serial)) AS rezultat
FROM filme_pt_utilizatori f, seriale_pt_utilizatori s
WHERE f.id_utilizator = s.id_utilizator;

SELECT id_subordonat, id_reprezentant, id_utilizator, LEVEL
FROM utilizatori
CONNECT BY PRIOR id_subordonat = id_reprezentant
START WITH id_subordonat = 125
ORDER BY LEVEL ASC;

SELECT LEVEL, LPAD('', LEVEL) || id_subordonat AS organigrama
FROM utilizatori
CONNECT BY PRIOR id_subordonat = id_reprezentant
START WITH id_subordonat = 125;

SELECT id_subordonat, id_reprezentant, id_utilizator, LEVEL
FROM utilizatori
CONNECT BY id_subordonat = PRIOR id_reprezentant
START WITH id_subordonat = 162;

SELECT id_subordonat, id_reprezentant, id_utilizator, LEVEL
FROM utilizatori
WHERE LEVEL = 3
CONNECT BY PRIOR id_subordonat = id_reprezentant
ORDER BY id_utilizator DESC;


SELECT nume_serial, durata_medie_episod, rating_s
FROM seriale
WHERE durata_medie_episod < (SELECT durata_medie_episod FROM seriale WHERE nume_serial = 'YOU');

SELECT nume_film, gen_film, rating_f
FROM filme
WHERE gen_film = (SELECT gen_film FROM filme WHERE nume_film = 'Marriage Story');


SELECT nume_serial, rating_s FROM seriale WHERE rating_s < 8.3 AND preferinte_util = 348102;

SELECT nume_film FROM filme_pt_utilizatori ORDER BY potrivire_f DESC;

SELECT id_abonament, perioada_testare, nvl2(perioada_testare, 11, 12) AS luni_de_plata FROM abonamente;

SELECT * FROM utilizatori WHERE telefon LIKE '073%';


CREATE OR REPLACE VIEW view_filme_94 
AS SELECT * FROM filme_pt_utilizatori WHERE potrivire_f = 94;
SELECT * FROM view_filme_94;

CREATE OR REPLACE VIEW view_d_h_t 
AS SELECT * FROM recomandari WHERE preferinte_util IN(941658, 789721, 216837);
SELECT * FROM view_d_h_t;

SELECT view_name FROM user_views;


CREATE INDEX idx_nume ON utilizatori(nume);

CREATE INDEX idx_pret ON detalii_abonament(pret);

SELECT * FROM user_indexes;

DROP INDEX idx_pret;


CREATE SEQUENCE secv_utilizatori
START WITH 10 INCREMENT BY 1
MAXVALUE 50 NOCYCLE;

ALTER SEQUENCE secv_utilizatori MAXVALUE 70;

SELECT * FROM user_sequences;


CREATE SYNONYM fu FOR filme_pt_utilizatori;

CREATE SYNONYM su FOR seriale_pt_utilizatori;

SELECT * FROM user_synonyms;


DROP TABLE abonamente PURGE;
DROP TABLE detalii_abonament PURGE;
DROP TABLE filme PURGE;
DROP TABLE filme_pt_utilizatori PURGE;
DROP TABLE recomandari PURGE;
DROP TABLE seriale PURGE;
DROP TABLE seriale_pt_utilizatori PURGE;
DROP TABLE utilizatori PURGE;