* Crearea unui set de date SAS din fisiere externe;
libname Proiect '/home/u61072806';
data Proiect.Info_Angajati;
	infile '/home/u61072806/angajati.csv' delimiter = ',';
	input ID Varsta Educatie $ Statut_marital $ Vechime Salariu_anual Copii;
run;

libname Proiect '/home/u61072806';
data Proiect.Cumparaturi_Angajati;
	infile '/home/u61072806/shopping.csv'  delimiter = ',';
	input ID Gen $ Varsta Salariu_anual Credit_score Spending_score;
run;


* Crearea si folosirea de formate definite de utilizator;
libname Proiect '/home/u61072806';
proc format;
value Copii low-0.9 = 'Fara copii'
			1-high = 'Copil'
			other = 'Format necorespunzator';
run;
title "Informatii despre angajati";
proc print data = Proiect.Info_Angajati noobs label;
var ID Varsta Educatie Statut_marital  Vechime Salariu_anual Copii;
format Copii Copii.;
format Salariu_anual dollar11.;
run;

libname Proiect '/home/u61072806';
proc format;
value $Gen 'Male' = 'M'
			'Female' = 'F'
			other = 'Format necorespunzator';
run;
title "Informatii despre cumparaturile efectuate de angajati";
proc print data = Proiect.Cumparaturi_Angajati noobs label;
var ID Gen Varsta Salariu_anual Credit_score Spending_score;
format Gen $Gen.;
format Salariu_anual dollar11.;
run;


* Procesare iterativa si conditionala;
* 1. Instructiunea WHERE;
libname Proiect '/home/u61072806';
title "Persoanele de sex feminin cu varsta peste 55 ani";
proc print data = Proiect.Cumparaturi_Angajati noobs label;
	where Gen eq 'Female' and
			Varsta ge 55;
var ID Gen Varsta Salariu_anual Credit_score Spending_score;
run;

* 2. Instructiunea IF;
libname Proiect '/home/u61072806';
data Proiect.Categorii_scor;
set Proiect.Cumparaturi_Angajati;
if Credit_score ='.' then Categorie_Credit_score = 'Fara categorie';
	else if Credit_score ge 300 and Credit_score lt 580 then Categorie_Credit_score = 'Poor';
		else if Credit_score ge 580 and Credit_score lt 670 then Categorie_Credit_score = 'Fair';
			else if Credit_score ge 670 and Credit_score lt 740 then Categorie_Credit_score = 'Good';
				else if Credit_score ge 740 and Credit_score lt 800 then Categorie_Credit_score = 'Very good';
					else if Credit_score ge 800 and Credit_score le 900 then Categorie_Credit_score = 'Excellent';
title "Categoriile specifice Credit Score pentru fiecare angajat";
proc print data = Proiect.Categorii_scor noobs label;
run;

* 3. Instructiunea SELECT;
libname Proiect '/home/u61072806';
data Proiect.Info_Actualizate;
set Proiect.Info_Angajati;
select;
	when (Copii lt 0) InfoCopii = 'Informatie eronata';
	when (missing(Copii)) InfoCopii = 'Nu a declarat';
	when (Copii eq 0) InfoCopii = 'Fara copil';
	otherwise InfoCopii = 'Copil';
end;
title "Informatii actualizate despre angajati";
proc print data = Proiect.Info_Actualizate noobs label;
run;


* Manipularea datelor prin functii SAS;
* 1. Functia SUM();
libname Proiect '/home/u61072806';
data Bonus_Prima;
set Proiect.Info_Angajati;
prima_vacanta = 650;
	if Vechime lt 5 then bonus = 0.03;
		else if Vechime ge 5 and Vechime lt 10 then bonus = 0.08;
			else if Vechime ge 10 and Vechime lt 15 then bonus = 0.12;
				else if Vechime ge 15 then bonus = 0.15;
Venit_total = sum(Salariu_anual*(1 + bonus), prima_vacanta);
format Salariu_anual dollar11.;
format Venit_total dollar11.;
run;
title "Veniturile totale ale angajatilor in functie de prima de vacanta si bonusuri";
proc print data = Bonus_Prima noobs label;
run;

* 2. Functia ROUND();
libname Proiect '/home/u61072806';
data Salarii;
set Proiect.Info_Angajati;
Salariu_lunar = ROUND(Salariu_anual/12, .1);
format Salariu_anual dollar11.;
format Salariu_lunar dollar11.1;
title "Informatii despre salariile angajatilor";
proc print data = Salarii noobs label; 
run;

* 3. Functia SUBSTR();
libname Proiect '/home/u61072806';
data Cod_Statut_marital;
set Proiect.Info_Angajati;
Cod_Statut_marital = SUBSTR(Statut_marital, 1, 3); 
title "Informatii despre statuturile maritale ale angajatilor";
proc print data = Cod_Statut_marital noobs label;
run;


* Combinarea seturilor de date;
* 1. Proceduri specifice SAS;
* 1.1.  Concatenarea seturilor de date folosind declaratia SET;
libname Proiect '/home/u61072806';
data Angajati_genF Angajati_genM;
set Proiect.Cumparaturi_Angajati;
if Gen eq 'Female' then output Angajati_genF;
	else if Gen eq 'Male' then output Angajati_genM;
run;
title "Informatii despre angajatii de sex feminin";
proc print data = Angajati_genF noobs label;
run;

title "Informatii despre angajatii de sex masculin";
proc print data = Angajati_genM noobs label;
run;

data Concatenare_angajati;
set Angajati_genF Angajati_genM;
run;
title "Informatii despre cumparaturile angajatilor - concatenate";
proc print data = Concatenare_angajati noobs label;
run;

* 1.2. Interclasarea seturilor de date folosind declaratia SET;
libname Proiect '/home/u61072806';
data Angajati_genF Angajati_genM;
set Proiect.Cumparaturi_Angajati;
if Gen eq 'Female' then output Angajati_genF;
	else if Gen eq 'Male' then output Angajati_genM;
run;
proc sort data = Angajati_genF;
by Credit_score;
run;
title "Informatii despre angajatii de sex feminin";
proc print data = Angajati_genF noobs label;
run;

proc sort data = Angajati_genM;
by Credit_score;
run;
title "Informatii despre angajatii de sex masculin";
proc print data = Angajati_genM noobs label;
run;

data Interclasare_angajati;
set Angajati_genF Angajati_genM;
by Credit_score;
run;
title "Informatii despre cumparaturile angajatilor - interclasate";
proc print data = Interclasare_angajati noobs label;
run;

* 1.3. Fuziune pe baza unei corespondente unu-la-unu;
libname Proiect '/home/u61072806';
proc sort data = Proiect.Info_Angajati;
by ID;
run;

proc sort data = Proiect.Cumparaturi_Angajati;
by ID;
run;

data Proiect.Info_complete;
merge Proiect.Info_Angajati Proiect.Cumparaturi_Angajati;
by ID;
run;

title "Informatii complete despre angajati";
proc print data = Proiect.Info_complete noobs label;
run;

* 1.4. Fuziune pe baza unei corespondente unu-la-multi;
libname Proiect '/home/u61072806';
data Proiect.Info_Bonusuri;
set Proiect.Info_Angajati;
	if Vechime lt 5 then Bonus = 0.03;
		else if Vechime ge 5 and Vechime lt 10 then Bonus = 0.08;
			else if Vechime ge 10 and Vechime lt 15 then Bonus = 0.12;
				else if Vechime ge 15 then Bonus = 0.15;
proc sort data = Proiect.Info_Bonusuri;
by Vechime;
run;

proc sort data = Proiect.Info_Angajati;
by Vechime;
run;

data Angajati_bonusuri;
merge Proiect.Info_Angajati Proiect.Info_Bonusuri;
by Vechime;
Venit_total = ROUND(Salariu_anual*(1 + Bonus), .1);
format Salariu_anual dollar11.;
format Venit_total dollar11.1;
title "Informatii despre veniturile totale al angajatilor in functie de bonusul primit";
proc print data = Angajati_bonusuri noobs label;
run;

* 2. Proceduri specifice SQL;
* 1. Inner join;
libname Proiect '/home/u61072806';
proc SQL;
create table Inner_join as
select * from Proiect.Info_Angajati as a, Proiect.Cumparaturi_Angajati as c
where a.ID = c.ID;
quit;
title "Inner join";
proc print data = Inner_join noobs label;
run;

* 2. Left join;
libname Proiect '/home/u61072806';
proc SQL;
create table Left_join as
select * from Proiect.Info_Angajati as a left join Proiect.Cumparaturi_Angajati as c
on a.ID = c.ID;
quit;
title "Left join";
proc print data = Left_join noobs label;
run;

* 3. Right join;
libname Proiect '/home/u61072806';
proc SQL;
create table Right_join as
select a.ID, c.Gen, a.Educatie, a.Vechime, a.Salariu_anual from Proiect.Info_Angajati as a right join Proiect.Cumparaturi_Angajati as c
on a.ID = c.ID;
quit;
title "Right join";
proc print data = Right_join noobs label;
run;

* 4. Full join;
libname Proiect '/home/u61072806';
proc SQL;
create table Full_join as
select a.ID, c.Gen, a.Varsta, a.Salariu_anual, c.Credit_score from Proiect.Info_Angajati as a full join Proiect.Cumparaturi_Angajati as c
on a.ID = c.ID;
quit;
title "Full join";
proc print data = Full_join noobs label;
run;


* Prelucrarea variabilelor cu ajutorul masivelor;
libname Proiect '/home/u61072806';
data Crestere_salariala;
set Proiect.Info_angajati;
array salariu(1) Salariu_anual;
	do i = 1 to 1;
		if salariu(i) lt 20000 then salariu(i) = salariu(i)*(1 + 0.15);
	end;
	drop i;
run;
title "Cresterea salariala cu 15% pentru angajatii cu un salariu mai mic de $20000";
proc print data = Crestere_salariala noobs label;
run;


* Prelucrarea datelor prin crearea de rapoarte si aplicarea de analize statistice;
* 1. Procedura PRINT;
libname Proiect '/home/u61072806';
data Prime;
set Proiect.Info_Angajati;
Prima = ROUND(0.04 * Salariu_anual, .1);
run;
proc sort data = Prime;
by Educatie;

format Salariu_anual dollar11.;
format Prima dollar11.1;
run;

proc print data = Prime noobs label;
by Educatie;
var ID Educatie Vechime Salariu_anual Prima;
title "Valorile primelor primite de angajati";
title2 "- ordonate dupa nivelul de educatie -";
run;

* 2. Procedura UNIVARIATE;
libname Proiect '/home/u61072806';
proc univariate data = Proiect.Info_Angajati plot;
var Salariu_anual;
title "Statistici descriptive - Salariu_anual";
run;

* 3. Procedura MEANS;
libname Proiect '/home/u61072806';
proc sort data = Proiect.Info_Angajati;
by Educatie;

proc means data = Proiect.Info_Angajati;
by Educatie;
var Varsta Vechime Salariu_anual;
title "Statistici descriptive - Varsta, Vechime si Salariu_anual";
run;

* 4. Procedura FREQ;
libname Proiect '/home/u61072806';
title "Tabele de frecvente - Educatie, Statut_marital";
proc freq data = Proiect.Info_Angajati;
tables Educatie;
tables Statut_marital;
run;

* 5. Procedura CORR;
libname Proiect '/home/u61072806';
proc corr data = Proiect.Info_Angajati;
var Varsta Vechime;
with Salariu_anual;
title "Corelatiile dintre variabilele Varsta si Vechime cu Salariu_anual";
run;

* 6. Procedura REG;
libname Proiect '/home/u61072806';
proc reg data = Proiect.Info_Angajati;
model Vechime = Varsta;
plot Vechime*Varsta;
title "Rezultate analiza de regresie";
run;


* Generarea de grafice;
* 1. Procedura GCHART;
libname Proiect '/home/u61072806';
title "Distributia angajatilor in functie de vechime si nivelul de educatie";
goptions reset = all;
proc gchart data = Proiect.Info_Angajati;
vbar3d Vechime Educatie;
run;
quit;

* 2. Procedura GPLOT;
libname Proiect '/home/u61072806';
title "Salariul anual incasat de un angajat in functie de vechimea in companie";
symbol value = dot;
proc gplot data = Proiect.Info_Angajati;
plot Salariu_anual*Vechime;
run;
quit;










