*Citire fisiere csv delimitate cu virgula;
data customers;
	infile '/home/u61072806/clienti.csv' delimiter = ',';
	input ID_client Tip_client $ Gen $ Oras_supermarket $ Rating_oferit;
run;
title "Informatii despre clienti";
proc print data = customers;

data products;
	infile '/home/u61072806/produse.csv' delimiter = ',';
	input Oras $ Categorie_produs $ Pret_unitar Data_achizitie : mmddyy10.;
	format Data_achizitie yymmdd10. Pret_unitar dollar11.2;
run;
title "Informatii despre produse";
proc print data = products;

data sales;
	infile '/home/u61072806/vanzari.csv' delimiter = ',';
	input Id_factura Tip_produs $ Pret Cantitate Taxa;
	label Id_factura = "Nr factura";
	format Pret dollar11.2 Taxa dollar11.3;
run;
title "Informatii despre vanzari";
proc print data = sales label;


*Subseturi;
*Clauza WHERE;
data makeup_fashion;
	set sales;
	where Tip_produs in ("Makeup", "Fashion");
	Total = (Pret * Cantitate) + Taxa;
	format Pret dollar11.2 Taxa dollar11.3 Total dollar11.2;
run;
title "Total vanzari produse de makeup si fashion";
proc print data = makeup_fashion noobs label;

*Clauza IF;
data member_rating;
	set customers;
	if Tip_client eq 'Member' and Rating_oferit lt 7;
	Rating_oferit = 1.3 * Rating_oferit;
run;
title "Cresterea rating-ului cu o valoare mai mica de 7 pentru membrii";
proc print data = member_rating noobs label;
var Id_client Tip_client Oras_supermarket Rating_oferit;


*Identificarea inregistrarilor incorecte;
data stores;
	infile '/home/u61072806/magazine.csv' delimiter = ',';
	length ID_zona $3 Stat $11 Tip_produs $10 Produs $17;
	input ID_zona $ Stat $ Tip_produs $ Produs $ Vanzari Data_vanzare : mmddyy10.;
	format Data_vanzare yymmdd10.;
run;
title "Informatii despre vanzarile magazinelor";
proc print data = stores;

title "Afisarea magazinelor care au valori incorecte";
data inreg_incorecte;
	set stores;
	file print; 
	if not ((ID_zona gt 100 and ID_zona lt 600) or ID_zona eq '.') then put Stat = Tip_produs = Vanzari =;
run;


*Stergerea inregistrarilor cu valori lipsa sau valori incorecte;
data stores_filtrate;
	set stores;
run;
title "Filtrarea magazinelor";
proc print data = stores_filtrate;
var ID_zona Tip_produs Vanzari;

title "Afisarea inregistrarilor cu valori corecte";
proc print data = stores_filtrate;
where not missing(ID_zona) and not missing(Tip_produs) and not missing(Vanzari);
var ID_zona Tip_produs Vanzari;
run;

data stores_deleted;
	set stores_filtrate;
	if missing(ID_zona) or missing(Tip_produs) or missing(Vanzari) or not (ID_zona gt 100 and ID_zona lt 600)
		then delete;
run;
title "Magazinele ramase dupa stergerea valorilor incorecte";
proc print data = stores_deleted;
var ID_zona Tip_produs Vanzari;


*Eliminarea valorilor duplicate;
proc freq data = stores;
tables Produs/nocum out = frecv;
run;

proc print data = frecv noobs label;
where count >= 2;
run;

proc sort data = stores out = stores_sorted;
	by Produs;
run;

data val_duplicate;
merge frecv (in = ind where = (count >= 2) keep = Produs count)
	stores_sorted (in = inp);
	by Produs;
if ind and inp;
	drop count;
run;

proc sort data = stores out = val_unicate noduprecs;
	by Produs;
run;

title "Afisarea magazinelor dupa stergerea valorilor duplicate";
proc print data = val_unicate noobs label;
id Produs;
run;


*Combinarea seturilor de date;
*Concatenare;
data customers2;
	infile '/home/u61072806/clienti2.csv' delimiter = ',';
	input ID_client Tip_client $ Gen $ Oras_supermarket $ Rating_oferit;
run;
title "Informatii despre clientii noi";
proc print data = customers2;

data customers_concatenat;
	set customers customers2;
run;
title "Informatii despre toti clientii";
proc print data = customers_concatenat noobs label;
run;

*Interclasare;
data stores1;
	infile '/home/u61072806/magazine1.csv' delimiter = ',';
	length ID_zona $3 Stat $13 Tip_produs $10 Produs $17;
	input ID_zona $ Stat $ Tip_produs $ Produs $ Vanzari Data_vanzare : mmddyy10.;
	format Data_vanzare yymmdd10.;
run;
title "Informatii despre vanzarile magazinelor";
proc print data = stores1;

data stores2;
	infile '/home/u61072806/magazine2.csv' delimiter = ',';
	length ID_zona $3 Stat $11 Tip_produs $10 Produs $17;
	input ID_zona $ Stat $ Tip_produs $ Produs $ Vanzari Data_vanzare : mmddyy10.;
	format Data_vanzare yymmdd10.;
run;
title "Informatii despre vanzarile magazinelor";
proc print data = stores2;

data stores_interclasate;
	set stores1 stores2;
	by ID_zona;
run;
title "Interclasarea informatiilor despre vanzarile magazinelor";
proc print data = stores_interclasate noobs label;

*Fuziune prin corespondenta;
data customers_nou;
	infile '/home/u61072806/clientiNou.csv' delimiter = ',';
	input ID_client Gen $ Tip_client $;
run;
title "Informatii despre clientii noi";
proc print data = customers_nou;

data customers_prod;
	infile '/home/u61072806/prodClienti.csv' delimiter = ',';
	input ID_client Tip_produs $ Pret Cantitate Taxa;
	format Pret dollar11.2 Taxa dollar11.3;
run;
title "Informatii despre produsele achizitionate de clienti";
proc print data = customers_prod;

data customers_fuziune;
	merge customers_nou (in = incustom)
		customers_prod (in = inprod);
	by ID_client;
	if incustom and inprod;
run;
title "Informatii despre clienti si produsele achizionate";
proc print data = customers_fuziune noobs label;


*Folosirea de proceduri specifice SQL;
libname ISAD '/home/u61072806/';
data ISAD.customers_nou;
	infile '/home/u61072806/clientiNou.csv' delimiter = ',';
	input ID_client Gen $ Tip_client $;
run;
title "Informatii despre clientii noi";
proc print data = ISAD.customers_nou;

data ISAD.customers_prod;
	infile '/home/u61072806/prodClienti.csv' delimiter = ',';
	input ID_client Tip_produs $ Pret Cantitate Taxa;
	format Pret dollar11.2 Taxa dollar11.3;
run;
title "Informatii despre produsele achizitionate de clienti";
proc print data = ISAD.customers_prod;

*Inner join;
proc SQL;
create table Inner_join as
select cn.ID_client, cn.Gen, cp.Tip_produs, cp.Pret, cp.Cantitate, cp.Pret * cp.Cantitate as Total_cumparaturi format = dollar11.2
from ISAD.customers_nou as cn, ISAD.customers_prod as cp
where cn.ID_client = cp.ID_client and cn.Gen eq 'Female';
quit;
title "Inner join";
proc print data = Inner_join noobs label;
run;


*Transpunerea datelor;
data stores_nou;
	infile '/home/u61072806/magazinNou.csv' delimiter = ',';
	length ID_zona $3 Tip_produs $10 Produs $17;
	input ID_zona $ Tip_produs $ Produs $ Vanzari Data_vanzare : mmddyy10.;
	format Data_vanzare yymmdd10.;
run;
title "Informatii despre noile vanzari ale magazinelor";
proc print data = stores_nou;

proc transpose data = stores_nou
				out = agg (drop = _name_)
				prefix = Vanzari;
	by ID_zona;
	id Tip_produs;
	var Vanzari;
run;
proc print data = agg noobs label;


*Agregarea datelor;
data stores_agg;
	set agg;
Medie_vanzari = round(mean(VanzariCoffee, VanzariEspresso, VanzariTea), 0.02);
Abatere_std_vanzari = round(std(VanzariCoffee, VanzariEspresso, VanzariTea), 0.02);
Mediana_vanzari = median(VanzariCoffee, VanzariEspresso, VanzariTea);
run;
title "Media, abaterea standard si mediana vanzarilor";
proc print data = stores_agg noobs label;
run;
	

















