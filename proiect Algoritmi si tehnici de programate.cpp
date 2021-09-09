// Realizați aplicația care monitorizează date despre activitatea utilizatorilor pe Netflix în ceea ce privește vizualizarea filmelor/serialelor în ultimele 2 luni (martie, aprilie).
// fisier organizat relativ

#include <stdio.h>
#include <string.h>

typedef struct {
	char is;
	int cod_util;
	char nume_f[500];
	char nume_s[500];
	int an;
	char gen[50];
	int recenzie;
	int nr_ep;
	float nr_acc[2];
	struct data {
		int zi;
		int luna;
		int an;
	} data_inreg;
}mnt;

int nr_art(FILE* f, int p)
{
	int n;
	fseek(f, 0, 2);
	n = ftell(f) / p;
	return n;
}

// crearea fisierului organizat relativ cu date despre utilizatorii Netflix cititi de la tastatura.
// cheia unica este codul utilizatorului.
// se vor introduce: numele filmului/serialului; genul; anul aparitiei; recenzia sub forma de nota (1-10); numarul de episoade va fi trecut doar in cazul serialelor, in dreptul filmelor trecandu-se '0'; data inregistrarii.

void creare()
{
	FILE* f;
	mnt x;
	int i, n;
	char nume_n[30];
	printf("\nIntroduceti numele fisierului:");
	gets_s(nume_n);
	f = fopen(nume_n, "wb+");
	printf("n=");
	scanf_s("%d", &n);
	while (!feof(stdin))
	{
		if (n > nr_art(f, sizeof(mnt)))
		{
			fseek(f, 0, 2);
			x.is = 0;
			for (i = nr_art(f, sizeof(mnt)); i < n; i++)
				fwrite(&x, sizeof(mnt), 1, f);
			fseek(f, (n - 1) * sizeof(mnt), 0);
			x.is = 1;
			x.cod_util = n;
			printf("Nume film:");
			getc(stdin);
			gets_s(x.nume_f);
			printf("Nume serial:");
			gets_s(x.nume_s);
			printf("Genul:");
			gets_s(x.gen);
			printf("Anul aparitei:");
			scanf_s("%d", &x.an);
			printf("Recenzie(nota):");
			scanf_s("%d", &x.recenzie);
			printf("Numar episoade(0 in cazul filmelor):");
			scanf_s("%d", &x.nr_ep);
			for (i = 0; i < 2; i++)
			{
				printf("Numarul accesarilor din luna %d:", i + 1);
				scanf_s("%f", &x.nr_acc[i]);
			}
			printf("Data inregistrarii pe Netflix(zi/luna/an):");
			scanf("%d %d %d", &x.data_inreg.zi, &x.data_inreg.luna, &x.data_inreg.an);
			fwrite(&x, sizeof(mnt), 1, f);
		}
		else {
			fseek(f, (n - 1) * sizeof(mnt), 0);
			fread(&x, sizeof(mnt), 1, f);
			if (x.is == 0)
			{
				x.is = 1;
				x.cod_util = n;
				printf("Nume film:");
				getc(stdin);
				gets_s(x.nume_f);
				printf("Nume serial:");
				gets_s(x.nume_s);
				printf("Genul:");
				gets_s(x.gen);
				printf("Anul aparitei:");
				scanf_s("%d", &x.an);
				printf("Recenzie(nota):");
				scanf_s("%d", &x.recenzie);
				printf("Numar episoade(0 in cazul filmelor):");
				scanf_s("%d", &x.nr_ep);
				for (i = 0; i < 2; i++)
				{
					printf("Numarul accesarilor din luna %d:", i + 1);
					scanf_s("%f", &x.nr_acc[i]);
				}
				printf("Data inregistrarii pe Netflix(zi/luna/an):");
				scanf("%d %d %d", &x.data_inreg.zi, &x.data_inreg.luna, &x.data_inreg.an);
				fseek(f, (n - 1) * sizeof(mnt), 0);
				fwrite(&x, sizeof(mnt), 1, f);
			}
			else printf("Inregistrarea exista\n");
		}
		printf("\n");
		printf("n=");
		scanf_s("%d", &n);
	}
	fclose(f);
}

// adaugarea noilor utilizatori Netflix.
// cheia unica este codul utilizatorului.
// se vor introduce: numele filmului/serialului; genul; anul aparitiei; recenzia sub forma de nota (1-10); numarul de episoade va fi trecut doar in cazul serialelor, in dreptul filmelor trecandu-se '0'; data inregistrarii.

void adaugare()
{
	FILE* f;
	mnt x;
	int i, n;
	char nume_n[30];
	printf("\nIntroduceti numele fisierului:");
	gets_s(nume_n);
	f = fopen(nume_n, "rb+");
	if (f == NULL)
		f = fopen(nume_n, "wb+");
	printf("n=");
	scanf_s("%d", &n);
	while (!feof(stdin))
	{
		if (n > nr_art(f, sizeof(mnt)))
		{
			fseek(f, 0, 2);
			x.is = 0;
			for (i = nr_art(f, sizeof(mnt)); i < n; i++)
				fwrite(&x, sizeof(mnt), 1, f);
			fseek(f, (n - 1) * sizeof(mnt), 0);
			x.is = 1;
			x.cod_util = n;
			printf("Nume film:");
			getc(stdin);
			gets_s(x.nume_f);
			printf("Nume serial:");
			gets_s(x.nume_s);
			printf("Genul:");
			gets_s(x.gen);
			printf("Anul aparitei:");
			scanf_s("%d", &x.an);
			printf("Recenzie(nota):");
			scanf_s("%d", &x.recenzie);
			printf("Numar episoade(0 in cazul filmelor):");
			scanf_s("%d", &x.nr_ep);
			for (i = 0; i < 2; i++)
			{
				printf("Numarul accesarilor din luna %d:", i + 1);
				scanf_s("%f", &x.nr_acc[i]);
			}
			printf("Data inregistrarii pe Netflix(zi/luna/an):");
			scanf("%d %d %d", &x.data_inreg.zi, &x.data_inreg.luna, &x.data_inreg.an);
			fseek(f, (n - 1) * sizeof(mnt), 0);
			fwrite(&x, sizeof(mnt), 1, f);
		}
		else {
			fseek(f, (n - 1) * sizeof(mnt), 0);
			fread(&x, sizeof(mnt), 1, f);
			if (x.is == 0)
			{
				x.is = 1;
				x.cod_util = n;
				printf("Nume film:");
				getc(stdin);
				gets_s(x.nume_f);
				printf("Nume serial:");
				gets_s(x.nume_s);
				printf("Genul:");
				gets_s(x.gen);
				printf("Anul aparitei:");
				scanf_s("%d", &x.an);
				printf("Recenzie(nota):");
				scanf_s("%d", &x.recenzie);
				printf("Numar episoade(0 in cazul filmelor):");
				scanf_s("%d", &x.nr_ep);
				for (i = 0; i < 2; i++)
				{
					printf("Numarul accesarilor din luna %d:", i + 1);
					scanf_s("%f", &x.nr_acc[i]);
				}
				printf("Data inregistrarii pe Netflix(zi/luna/an):");
				scanf("%d %d %d", &x.data_inreg.zi, &x.data_inreg.luna, &x.data_inreg.an);
				fseek(f, (n - 1) * sizeof(mnt), 0);
				fwrite(&x, sizeof(mnt), 1, f);
			}
			else printf("Inregistrarea exista");
		}
		printf("\n");
		printf("n=");
		scanf_s("%d", &n);
	}
	fclose(f);
}

// modificarea datei de inregistrare a utilizatorilor cititi de la tastatura.
// data va fi de forma: zi luna an.

void modificare()
{
	FILE* f;
	mnt x;
	int n;
	int zi_d, luna_d, an_d;
	char nume_n[30];
	printf("\nIntroduceti numele fisierului:");
	gets_s(nume_n);
	if (!(f = fopen(nume_n, "rb+")))
		printf("Fisierul nu exista!");
	else {
		printf("\n");
		printf("Modificati data inregistrarii utilizatorului");
		printf("\n");
		printf("n=");
		scanf_s("%d", &n);
		while (!feof(stdin))
		{
			if (n > nr_art(f, sizeof(mnt)))
				printf("Este depasita lungimea fisierului");
			else {
				fseek(f, (n - 1) * sizeof(mnt), 0);
				fread(&x, sizeof(mnt), 1, f);
				if (x.is == 1)
				{
					printf("Zi:");
					scanf("%d", &zi_d);
					x.data_inreg.zi = zi_d;
					printf("Luna:");
					scanf("%d", &luna_d);
					x.data_inreg.luna = luna_d;
					printf("An:");
					scanf("%d", &an_d);
					x.data_inreg.an = an_d;
					fseek(f, (n - 1) * sizeof(mnt), 0);
					fwrite(&x, sizeof(mnt), 1, f);
				}
				else printf("Inregistrarea nu exista!");
			}
			printf("\n");
			printf("n=");
			scanf_s("%d", &n);
		}
		fclose(f);
	}
}

// stergerea din sistem a utilizatorilor cititi de la tastatura, ca urmare a neefectuarii platii abonamentului Netflix.

void stergere()
{
	FILE* f;
	mnt x;
	int n;
	char nume_n[30];
	printf("\nIntroduceti numele fisierului:");
	gets_s(nume_n);
	if (!(f = fopen(nume_n, "rb+")))
		printf("Fisierul nu exista!");
	else {
		printf("\n");
		printf("Stergeti utilizatorul Netflix (nu a efectuat plata)");
		printf("\n");
		printf("n=");
		scanf("%d", &n);
		while (!feof(stdin))
		{
			if (n > nr_art(f, sizeof(mnt)))
				printf("Este depasita lungimea fisierului");
			else {
				fseek(f, (n - 1) * sizeof(mnt), 0);
				fread(&x, sizeof(mnt), 1, f);
				if (x.is == 1)
				{
					x.is = 0;
					fseek(f, (n - 1) * sizeof(mnt), 0);
					fwrite(&x, sizeof(mnt), 1, f);
				}
				else printf("Inregistrarea nu exista!");
			}
			printf("\n");
			printf("n=");
			scanf("%d", &n);
		}
		fclose(f);
	}
}

// afisarea generala a tuturor datelor inregistrate anterior despre utilizatorii Netflix intr-un fisier text numit "lista_inreg.txt".

void afisare()
{
	FILE* f, * g;
	mnt x;
	char nume_n[30];
	printf("\nIntroduceti numele fisierului:");
	gets_s(nume_n);
	if (!(f = fopen(nume_n, "rb")))
		printf("Fisierul nu exista!");
	else {
		g = fopen("lista_inreg.txt", "w");
		fprintf(g, "                                                       FILMELE/SERIALELE ACCESATE DE UTILIZATORI PE NETFLIX                                     ");
		fprintf(g, "\n");
		fprintf(g, "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
		fprintf(g, "\n");
		fprintf(g, "||COD UTILIZATOR||          NUME FILM         ||         NUME SERIAL        ||     GENUL     ||ANUL APARITIEI||RECENZIE(NOTA)||LUNA 1||LUNA 2||NUMAR EPISOADE||DATA INREGISTRARII||");
		fprintf(g, "\n");
		fprintf(g, "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
		fread(&x, sizeof(mnt), 1, f);
		while (!feof(f))
		{
			if (x.is == 1)
			{
				fprintf(g, "\n");
				fprintf(g, "|| %10d   ||     %15s        ||     %21s  ||   %8s    ||     %4d     ||      %2d      ||%4.0f  ||%4.0f  ||     %4d     ||     %2d/%2d/%4d   ||", x.cod_util, x.nume_f, x.nume_s, x.gen, x.an, x.recenzie, x.nr_acc[0], x.nr_acc[1], x.nr_ep, x.data_inreg.zi, x.data_inreg.luna, x.data_inreg.an);
			}
			fread(&x, sizeof(mnt), 1, f);
		}
		fclose(f);
		fclose(g);
	}
}

// afisarea partiala ce presupune afisarea in fisierul text "lista_fs.txt" a filmelor/serialelor a caror recenzie este citita de la tastatura.
// recenzia va fi citita sub forma de nota (1-10).

void afisare_fs()
{
	FILE* f, * g;
	mnt x;
	int n, ok, r;
	char nume_n[30];
	printf("\nIntroduceti numele fisierului:");
	gets_s(nume_n);
	if (!(f = fopen(nume_n, "rb")))
		printf("Fisierul nu exista!");
	else {
		g = fopen("lista_fs.txt", "w");
		fprintf(g, "                                                       RECENZII(NOTA) - FILME/SERIALE NETFLIX                                     ");
		fprintf(g, "\n");
		fprintf(g, "-----------------------------------------------------------------------------------------------------------------------------------------------");
		fprintf(g, "\n");
		fprintf(g, "||COD UTILIZATOR||          NUME FILM         ||         NUME SERIAL        ||     GENUL     ||ANUL APARITIEI||RECENZIE(NOTA)||NUMAR EPISOADE||");
		fprintf(g, "\n");
		fprintf(g, "-----------------------------------------------------------------------------------------------------------------------------------------------");
		printf("\n");
		printf("r=");
		scanf("%d", &r);
		ok = 0;
		fread(&x, sizeof(mnt), 1, f);
		while (!feof(f))
		{
			if ((x.is == 1) && (x.recenzie == r))
			{
				fprintf(g, "\n");
				fprintf(g, "|| %10d   ||     %15s        ||     %21s  ||   %8s    ||     %4d     ||      %2d      ||     %4d     ||", x.cod_util, x.nume_f, x.nume_s, x.gen, x.an, x.recenzie,  x.nr_ep);
				ok = 1;
			}
			fread(&x, sizeof(mnt), 1, f);
		}
		if (ok == 0)
			printf("Inregistrarea nu exista!");
		fclose(f);
		fclose(g);
	}
}

void main()
{
	//creare();
	//adaugare();
	//modificare();
	//stergere();
	//afisare();
	//afisare_fs();
}