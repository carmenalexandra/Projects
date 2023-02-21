// Aplicatie pentru gestiunea vanzarilor unui magazin ca multime de vanzari individuale (cod produs, denumire, pret unitar, cantitate), pe zile calendaristice. Aplicatia permite calculul totalului valoric al vanzarilor magazinului pe o perioada, zilele cu incasarile cele mai mari, respectiv cele mai mici. 

#include <iostream>
#include <string>
using namespace std;


//definirea clasei Data_calendaristica
class Data_calendaristica
{
public:
	int zi;
	int luna;
	int an;
};

//definirea clasei Produs
class Produs
{
public:
	int cod;
	string denumire;
	float pret;
	int cantitate;
	Data_calendaristica data;

	float valoare()
	{
		float total_produs = 0;
		total_produs = this->pret * this->cantitate;
		return total_produs;
	}

	Produs()
	{
		this->cod = 0;
		this->denumire = "fara denumire";
		this->pret = 0;
		this->cantitate = 0;
		this->data.zi = 0;
		this->data.luna = 0;
		this->data.an = 0;

	}

	Produs(const Produs& p)
	{
		this->cod = p.cod;
		this->denumire = p.denumire;
		this->pret = p.pret;
		this->cantitate = p.cantitate;
		this->data.zi = p.data.zi;
		this->data.luna = p.data.luna;
		this->data.an = p.data.an;

	}

	friend ostream& operator << (ostream& os, const Produs& p)
	{
		os << "Produsul cu codul " << p.cod << " (" << p.denumire << ") are pretul unitar " << p.pret << " lei" << " si s-au vandut " << p.cantitate << " bucati, in data de " << p.data.zi << "." << p.data.luna << "." << p.data.an << endl;
		return os;
	}

	friend istream& operator >> (istream& is, Produs& p)
	{
		cout << "Cod produs: ";
		is >> p.cod;
		cout << "Denumire: ";
		is >> p.denumire;
		cout << "Pret unitar: ";
		is >> p.pret;
		cout << "Cantitate: ";
		is >> p.cantitate;
		cout << "Zi: ";
		is >> p.data.zi;
		cout << "Luna: ";
		is >> p.data.luna;
		cout << "An: ";
		cin >> p.data.an;
		return is;
	}
};

//definirea clasei Magazin
class Magazin {
public:
	string nume;
	int nr_produse;
	Produs* produse;

	Magazin()
	{
		this->nume = "fara nume";
		this->nr_produse = 0;
	}

	Magazin(const Magazin& m)
	{
		this->nume = m.nume;
		this->nr_produse = m.nr_produse;
	}

	float valoare_totala()
	{
		float total = 0;
		for (int i = 0; i < this->nr_produse; i++)
		{
			total += produse[i].cantitate * produse[i].pret;
		}
		return total;
	}

private:
	friend istream& operator >> (istream& is, Magazin& m)
	{
		cout << "Nume magazin: ";
		is >> m.nume;
		cout << "Nr. produse: ";
		is >> m.nr_produse;
		cout << endl;
		if (m.produse != NULL)
		{
			delete[] m.produse;

		}
		m.produse = new Produs[m.nr_produse];
		for (int i = 0; i < m.nr_produse; i++)
		{
			cout << "Produsul " << i + 1 << ": " << endl;
			is >> m.produse[i];
			cout << endl;
		}
		return is;
	}
	friend ostream& operator << (ostream& os, const Magazin& m)
	{
		os << "Numele magazinului este " << m.nume << " si a vandut " << m.nr_produse << " produse:" << endl;
		for (int i = 0; i < m.nr_produse; i++)
		{
			os << "Produsul " << i + 1 << ": " << endl;
			os << m.produse[i];
		}
		return os;
	}
};

int main()
{
	Magazin m;
	cin >> m;
	cout << m;

	float a[32];
	float t;
	int zi;
	int luna;
	int an;
	for (int i = 0; i < 32; i++)
	{
		a[i] = 0;
	}
	for (int i = 0; i < m.nr_produse; i++)
	{
		zi = m.produse[i].data.zi;
		luna = m.produse[i].data.luna;
		an = m.produse[i].data.an;
		t = m.produse[i].valoare();
		if (t > a[zi])
		{
			a[zi] = t;
		}
		cout << endl;
		cout << "In data de " << zi << "." << luna << "." << an << " s-a incasat suma de " << a[zi] << " lei." << endl;
	}
	
	cout << endl;
	cout << "Valoarea totala incasata pentru toate zilele introduse este: " << m.valoare_totala() << " lei." << endl;

	float max, min;
	int k = 0;
	max = a[0];
	for (int i = 0; i < 32; i++)
	{
		if (a[i] > max)
		{
			max = a[i];
			k = i;
		}
	}
	cout << endl;
	cout << "Ziua in care s-au inregistrat cele mai multe vanzari este " << k << ", cu o suma incasata de " << max << " lei." << endl;

	int p = 0;
	int g = 0;
	while (p == 0)
	{
		if (a[g] == 0)
		{
			p = 0;
			g++;
		}
		else p = 1;
	}
	min = a[g];
	int v = 0;
	for (int i = 0; i < 32; i++)
	{
		if (a[i] != 0)
		{
			if (a[i] < min)
			{
				min = a[i];
				v = i;
			}

		}
	}
	cout << endl;
	cout << "Ziua in care s-au inregistrat cele mai putine vanzari este " << v << ", cu o suma incasata de " << min << " lei." << endl;
}
