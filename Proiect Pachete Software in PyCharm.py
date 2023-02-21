# Lista
# 1. Crearea si afisarea unei liste
import pandas

prodApple = ["iPhone", "iPad", "iMac", "Apple Watch", "Apple TV"]
print(prodApple)

# 2. Crearea unei liste prin intermediul constructorului list()
produseApple1 = list(("iPhone", "iPad", "iMac", "Apple Watch", "Apple TV"))
print(produseApple1)

# 3. Accesarea elem din lista prin index
prodApple = ["iPhone", "iPad", "iMac", "Apple Watch", "Apple TV"]
print(prodApple[2])

# 4. Modificarea unui element
prodApple = ["iPhone", "iPad", "iMac", "Apple Watch", "Apple TV"]
prodApple[1] = "iPod"
print(prodApple)

# 5. Adaugarea unui element la sfarsitul listei
prodApple = ["iPhone", "iPad", "iMac", "Apple Watch", "Apple TV"]
prodApple.append("iPod")
print(prodApple)

# 6. Crearea unei copii a listei
prodApple = ["iPhone", "iPad", "iMac", "Apple Watch", "Apple TV"]
prodApple_copie = prodApple.copy()
print(prodApple_copie)

# 7. Golirea listei
prodApple_copie.clear()
print(prodApple_copie)

# 8. Stergerea intregii liste
del prodApple_copie
print(prodApple_copie)

# 9. Eliminarea elem de la indexul specificat
prodApple = ["iPhone", "iPad", "iMac", "Apple Watch", "Apple TV"]
prodApple.pop(3)
print(prodApple)

# 10. Det nr elem din lista
prodApple = ["iPhone", "iPad", "iMac", "Apple Watch", "Apple TV"]
print(len(prodApple))


# Tuplu
# 1. Crearea si afisarea unui tuplu
filiale = ("Beats Electronics", "Beddit", "NextVR, Inc.", "Apple Store")
print(filiale)

# 2. Accesarea elem din tuplu prin index
filiale = ("Beats Electronics", "Beddit", "NextVR, Inc.", "Apple Store")
print(filiale[3])

# 3. Modificarea unui elem - nu este posibila
filiale[3] = "AuthenTec"

# 4. Afisarea nr de aparitii al unui elem in tuplu
filiale = ("Beats Electronics", "Beddit", "NextVR, Inc.", "Apple Store")
print(filiale.count("Beddit"))

# 5. Afisarea pozitiei unui elem in tuplu
filiale = ("Beats Electronics", "Beddit", "NextVR, Inc.", "Apple Store")
print(filiale.index("NextVR, Inc."))


# Set
# 1. Crearea si afisarea unui set
gadgetApple = {"AirPods", "Husa", "Adaptor", "Incarcator", "Cablu date"}
print(gadgetApple)

# 2. Crearea unui set prin intermediul constructorului set()
gadget = set("gadget")
print(gadget)

# 3. Adaugarea unui element in set
gadgetApple = {"AirPods", "Husa", "Adaptor", "Incarcator", "Cablu date"}
gadgetApple.add("Baterie externa")
print(gadgetApple)

# 4. Eliminarea unui element specificat din set
gadgetApple = {"AirPods", "Husa", "Adaptor", "Incarcator", "Cablu date"}
gadgetApple.discard("Adaptor")
print(gadgetApple)

# 5. Crearea unei copii a setului
gadgetApple = {"AirPods", "Husa", "Adaptor", "Incarcator", "Cablu date"}
gadgetApple_copie = gadgetApple.copy()
print(gadgetApple_copie)

# 6. Eliminarea tuturor elem unui set
gadgetApple_copie.clear()
print(gadgetApple_copie)


# Dictionar
# 1. Crearea si afisarea unui dictionar
infoApple = {"Infiintare":"1 apr 1976", "Sediu":"Cupertino, US", "Fondatori":"Steve Jobs, Steve Wozniak, Ronald Wayne"}
print(infoApple)

# 2. Crearea unui dictionar prin intermediul constructorului dict()
infoApple1 = dict(Infiintare = "1 apr 1976", Sediu = "Cupertino, US", Fondatori = "Steve Jobs, Steve Wozniak, Ronald Wayne")
print(infoApple1)

# 3. Accesarea elem din dictionar prin cheie
infoApple = {"Infiintare":"1 apr 1976", "Sediu":"Cupertino, US", "Fondatori":"Steve Jobs, Steve Wozniak, Ronald Wayne"}
cheie = infoApple["Fondatori"]
print(cheie)

# 4. Accesarea elem din dictionar prin metoda get()
infoApple = {"Infiintare":"1 apr 1976", "Sediu":"Cupertino, US", "Fondatori":"Steve Jobs, Steve Wozniak, Ronald Wayne"}
print(infoApple.get("Fondatori"))

# 5. Modificarea unui elem din dictionar prin cheie
infoApple = {"Infiintare":"1 apr 1976", "Sediu":"Cupertino, US", "Fondatori":"Steve Jobs, Steve Wozniak, Ronald Wayne"}
infoApple["Sediu"] = "California, US"
print(infoApple)

# 6. Afisarea unei liste ce contine un tuplu pt fiecare pereche cheie-valoare
infoApple = {"Infiintare":"1 apr 1976", "Sediu":"Cupertino, US", "Fondatori":"Steve Jobs, Steve Wozniak, Ronald Wayne"}
print(infoApple.items())

# 7. Actualizarea dictionarului cu o pereche cheie-valoare specificata
infoApple = {"Infiintare":"1 apr 1976", "Sediu":"Cupertino, US", "Fondatori":"Steve Jobs, Steve Wozniak, Ronald Wayne"}
infoApple.update({"Director executiv":"Tim Cook"})
print(infoApple)

# 8. Eliminarea elem avand o anumita cheie specificata
infoApple = {"Infiintare":"1 apr 1976", "Sediu":"Cupertino, US", "Fondatori":"Steve Jobs, Steve Wozniak, Ronald Wayne"}
infoApple.pop("Sediu")
print(infoApple)

# 9. Afisarea unei liste ce contine cheile dictionarului
infoApple = {"Infiintare":"1 apr 1976", "Sediu":"Cupertino, US", "Fondatori":"Steve Jobs, Steve Wozniak, Ronald Wayne"}
print(infoApple.keys())

# 10. Eliminarea ultimei perechi cheie-valoare adaugata in dictionar
infoApple = {"Infiintare":"1 apr 1976", "Sediu":"Cupertino, US", "Fondatori":"Steve Jobs, Steve Wozniak, Ronald Wayne"}
infoApple.popitem()
print(infoApple)



# Structuri de programare
# 1. Structuri conditionale
# Verificam daca o anumita filiala se regaseste in lista
filialeApple = list(("Beats Electronics", "Beddit", "NextVR, Inc.", "Apple Store"))

fil = input("Introduceti filiala dorita:\n")
print("Verificati existenta filialei:", fil)

verif = False

if(fil == "Beats Electronics"): verif = True
elif(fil == "Beddit"): verif = True
elif(fil == "NextVR, Inc."): verif = True
elif(fil == "Apple Store"): verif = True
else: print("Filiala nu exista in lista. Urmeaza a fi introdusa la sfarsitul listei:")

if(verif == True): print("Filiala introdusa exista!")
else: filialeApple.append(fil)

print("Filiale:",filialeApple)


# 2. Structuri repetitive
# Verificam daca exista un anumit element in lista
prodApple = ["iPhone", "iPad", "iMac", "Apple Watch", "Apple TV"]

elem = input("Introduceti elementul cautat:\n")
print("Elementul cautat este:", elem)
cond = False

for x in prodApple:
    if(x == elem): cond = True

if(cond == True): print(elem, "a fost gasit in lista de produse Apple.")
else: print("Eroare!",elem, "nu a fost gasit in lista de produse Apple.")



# Pachetul pandas
# 1. Importul unui fisier csv in pachetul pandas
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
print(date_angajati)


# 2. Accesarea datelor cu loc si iloc
# 2.1.1. Afisarea prin localizare cu loc a coloanelor ID, Varsta, Vechime pentru angajatul de la linia 70
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
print(date_angajati.loc[[70], ['ID', 'Varsta', 'Vechime', 'Salariu_anual']])

# 2.1.2. Afisarea prin localizare cu loc a coloanelor ID, Vechime, Salariu anual pentru angajatii care au o vechime mai mare de 10 ani
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
print(date_angajati.loc[(date_angajati.Vechime >= 10), ['ID', 'Vechime', 'Salariu_anual']])

# 2.1.3. Afisarea  prin localizare cu loc a coloanelor ID, Statut marital, Varsta, Copii pentru angajatii care sunt divortati
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
print(date_angajati.loc[(date_angajati.Statut_marital == 'Divorced'), ['ID', 'Statut_marital', 'Varsta', 'Copii']])

# 2.2.1. Afisarea prin localizare cu iloc a primelor 4 coloane din setul de date pentru angajatii de la liniile 90-101
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
print(date_angajati.iloc[90:101, 0:4])

# 2.2.2. Afisarea prin localizare cu iloc a coloanelor 4 si 5 pentru angajatii de la liniile 12 si 112
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
print(date_angajati.iloc[[12, 112], 4:6])


# 3. Modificarea datelor in pachetul pandas
# 3.1. Modificarea salariului anual pentru angajatul de la linia 47
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
print(date_angajati.loc[47, 'Salariu_anual'])
date_angajati.loc[47, 'Salariu_anual'] = 31550
print(date_angajati.loc[47, 'Salariu_anual'])

# 3.2. Modificarea nivelului de educatie al angajatului cu ID-ul 4518 din Bachelor in PhD
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
date_copie = date_angajati.copy()
print(date_copie.loc[(date_copie['ID'] == 4518), ['ID', 'Educatie', 'Salariu_anual']])
date_copie.loc[(date_copie['ID'] == 4518), 'Educatie'] = 'PhD'
print(date_copie.loc[(date_copie['ID'] == 4518) & (date_copie['Educatie'] == 'PhD'), ['ID', 'Educatie', 'Salariu_anual']])

# 3.3. Identificarea si modificarea tipului de data pentru variabila Salariu_anual
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
print(date_angajati.dtypes)
date_angajati.Salariu_anual = date_angajati.Salariu_anual.astype(float)
print(date_angajati.dtypes)


# 4. Definirea si utilizarea unor functii
# Modificarea venitului total pentru angajatii cu o vechime mai mare de 15 ani in companie, care urmeaza a primi o marire
# in valoare de $650.
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')

def functie_calcul_venit(x):
    return(x + 650)

angajati = date_angajati.copy()
print(date_angajati.loc[(date_angajati['Vechime'] >= 15), ['Salariu_anual']])
print(angajati.loc[(angajati['Vechime'] >= 15), ['Salariu_anual']].apply(functie_calcul_venit))



# 5. Functii de grup
# 5.1. Afisarea salariului mediu anual, grupat dupa cele 3 nivele de educatie
import pandas as pd
date_sumare = pd.read_csv('angajati.csv', usecols = ('Educatie', 'Salariu_anual'))
print(date_sumare.groupby(['Educatie']).mean())

# 5.2. Afisarea numarului de angajati din setul de date, grupati dupa statutul marital
import pandas as pd
date_sumare1 = pd.read_csv('angajati.csv', usecols = ('ID', 'Statut_marital'))
print(date_sumare1.groupby(['Statut_marital']).count())

# 5.3. Afisarea numarului total de copii declarati la HR de catre angajatii companiei, grupati dupa statutul marital
import pandas as pd
date_sumare2 = pd.read_csv('angajati.csv', usecols = ('Statut_marital', 'Copii'))
print(date_sumare2[date_sumare2['Copii'] == 1].groupby(['Statut_marital']).sum())

# 5.4. Afisarea primelor inregistrari din coloana Educatie pe cele 3 tipuri de diploma pentru studii superioare
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
print(date_angajati.groupby('Educatie').first())


# 6. Tratarea valorilor lipsa
# 6.1. Inlocuirea valorilor lipsa in setul de date apple.csv
import pandas as pd
date_apple = pd.read_csv('apple.csv')
pd.options.display.max_columns = 22
print(date_apple)
print(date_apple['28/03/2020'].fillna('lipsa'))
print(date_apple['28/12/2019'].fillna('lipsa'))
print(date_apple['28/09/2019'].fillna('lipsa'))
print(date_apple['29/06/2019'].fillna('lipsa'))
print(date_apple['30/03/2019'].fillna('lipsa'))
print(date_apple['29/12/2018'].fillna('lipsa'))
print(date_apple['29/09/2018'].fillna('lipsa'))
print(date_apple['30/06/2018'].fillna('lipsa'))
print(date_apple['31/03/2018'].fillna('lipsa'))


# 7. Stergerea de coloane si inregistrari
# 7.1. Stergerea coloanei Copii utilizand parametrul columns
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
date_angajati1 = date_angajati.drop(columns = "Copii")
print(date_angajati1)

# 7.2. Stergerea angajatilor care au Masterul ca nivel de educatie
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
date_angajati2 = date_angajati.set_index("Educatie")
date_angajati2 = date_angajati2.drop("Master", axis = 0)
print(date_angajati2)

# 7.3. Preluarea coloanelor ID, Statut_marital si Copii cu functia usecols si eliminarea inregistrarilor de la liniile 13-20 cu functia skiprows
import pandas as pd
date_angajati1 = pd.read_csv('angajati.csv', skiprows = [13, 14, 15, 16, 17, 18, 19, 20], usecols = ['ID', 'Statut_marital', 'Copii'])
print(date_angajati1)


# 8. Prelucrari statistice, gruparea si agregarea datelor in pachetul pandas
# 8.1. Prelucrari statistice simple
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
print('Numar angajati:')
print(date_angajati['ID'].count())
print('Cea mai mare vechime a unui angajat al companiei:')
print(date_angajati['Vechime'].max(), 'ani')
print('Cel mai tanar angajat are varsta:')
print(date_angajati['Varsta'].min(), 'ani')
print('Numarul total de copii declarati pentru angajatii casatoriti:')
print(date_angajati['Copii'][date_angajati['Statut_marital'] == 'Married'].sum())
print('Salariul mediu anual al unui angajat cu diploma de licenta')
print('$', format(date_angajati['Salariu_anual'][date_angajati['Educatie'] == 'Bachelor'].mean(), ".2f"))
print('Cate tipuri de diplome pentru studii superioare sunt consemnate pentru angajati:')
print(date_angajati['Educatie'].nunique())
print('Numarul de angajati pe fiecare tip de diploma pentru studii superioare')
print(date_angajati['Educatie'].value_counts())

# 8.2. Statisticile descriptive ale setului de date utilizand functia describe()
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
print('Statistici descriptive')
print(date_angajati.describe())

# 8.3. Afisarea numarului de angajati in functie de nivelul de educatie, a varstei minime si a salariului mediu anual, grupate dupa statutul marital si
# numarul de copii
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
print(date_angajati.groupby(['Statut_marital', 'Copii']).agg({'Educatie':"count",
                                                              'Varsta':min,
                                                              'Salariu_anual':"mean",}))

# 8.4. Afisarea salariului minim si maxim anual, valorile unice ale vechimii regasite in setul de date si varsta medie, grupate dupa statutul marital
# si nivelul de educatie
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
print(date_angajati.groupby(['Statut_marital', 'Educatie']).agg({'Salariu_anual': [min, max],
                                                                 'Vechime':'nunique',
                                                                 'Varsta':"mean"}))


# 9. Prelucrarea setului de date cu merge/join dataframes
# Importarea setului de date corespunzator cumparaturilor efectuate de angajatii companiei Apple
import pandas as pd
cumparaturi_angajati = pd.read_csv('shopping.csv')
print(cumparaturi_angajati)

# 9.1. Inner merge sau inner join
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
cumparaturi_angajati = pd.read_csv('shopping.csv')
rezultat = pd.merge(date_angajati[['ID', 'Varsta', 'Salariu_anual']], cumparaturi_angajati[['ID', 'Gen', 'Credit_score']], on = 'ID')
print(rezultat)
print('Structura fisier angajati.csv', date_angajati.shape)
print('Structura fisier shopping.csv', cumparaturi_angajati.shape)
print(date_angajati['ID'].isin(cumparaturi_angajati['ID']).value_counts())

# 9.2. Left merge sau left join
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
cumparaturi_angajati = pd.read_csv('shopping.csv')
rezultat = pd.merge(date_angajati, cumparaturi_angajati[['ID', 'Gen', 'Credit_score']], on = 'ID', how = 'left')
print(rezultat)
print('Structura fisier angajati.csv', date_angajati.shape)
print('Structura fisier shopping.csv', cumparaturi_angajati.shape)
print(date_angajati['ID'].isin(cumparaturi_angajati['ID']).value_counts())

# 9.3. Right merge si right join
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
cumparaturi_angajati = pd.read_csv('shopping.csv')
rezultat = pd.merge(date_angajati, cumparaturi_angajati[['ID', 'Gen', 'Credit_score']], on = 'ID', how = 'right')
print(rezultat)
print('Structura fisier angajati.csv', date_angajati.shape)
print('Structura fisier shopping.csv', cumparaturi_angajati.shape)
print(date_angajati['ID'].isin(cumparaturi_angajati['ID']).value_counts())

# 9.4. Full outer merge sau full outer join
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
cumparaturi_angajati = pd.read_csv('shopping.csv')
rezultat = pd.merge(date_angajati, cumparaturi_angajati[['ID', 'Gen', 'Credit_score']], on = 'ID', how = 'outer')
print(rezultat)
print('Structura fisier angajati.csv', date_angajati.shape)
print('Structura fisier shopping.csv', cumparaturi_angajati.shape)
print(date_angajati['ID'].isin(cumparaturi_angajati['ID']).value_counts())

# 9.5. Full outer merge sau full outer join cu indicatia _merge
import pandas as pd
date_angajati = pd.read_csv('angajati.csv')
cumparaturi_angajati = pd.read_csv('shopping.csv')
rezultat = pd.merge(date_angajati, cumparaturi_angajati[['ID', 'Gen', 'Credit_score']], on = 'ID', how = 'outer', indicator = True)
print(rezultat)
print('Structura fisier angajati.csv', date_angajati.shape)
print('Structura fisier shopping.csv', cumparaturi_angajati.shape)
print(date_angajati['ID'].isin(cumparaturi_angajati['ID']).value_counts())



# Pachetul matplotlib
# 1. Reprezentarea grafica cu bare a vechimii angajatilor in compania Apple
import pandas as pd
import matplotlib.pyplot as plt
date_angajati = pd.read_csv('angajati.csv')
date_angajati['Vechime'].plot(kind = 'bar', color = 'magenta')
plt.xlabel('ID', fontsize = 20)
plt.ylabel('Varsta', fontsize = 20)
plt.title('Vechimea angajatilor in compania Apple', fontsize = 30)
plt.show()

# 2. Reprezentarea grafica de tip histograma a distributiei varstelor angajatilor companiei Apple
import pandas as pd
import matplotlib.pyplot as plt
date_angajati = pd.read_csv('angajati.csv')
print(date_angajati['Varsta'])
date_angajati['Varsta'].plot(kind = 'hist', color = 'slateblue')
plt.xlabel('Varsta', fontsize = 20)
plt.title('Histograma distributiei varstelor angajatilor companiei Apple', fontsize = 25)
plt.show()

# 3. Reprezentarea grafica a salariului mediu anual pe fiecare tip de diploma pentru studii superioare pentru angajatii casatoriti
import pandas as pd
import matplotlib.pyplot as plt
date_angajati = pd.read_csv('angajati.csv')
plot_data = date_angajati[date_angajati['Statut_marital'] == 'Together']
plot_data = plot_data.groupby('Educatie')['Salariu_anual'].mean()
plot_data.sort_values().plot(kind = 'barh', color = 'darkseagreen')
plt.xlabel('Salariu mediu anual', fontsize = 15)
plt.ylabel('Educatie', fontsize = 15)
plt.title('Reprezentarea grafica a salariului mediu anual pe fiecare tip de diploma\npentru studii superioare pentru angajatii casatoriti', fontsize = 20)
plt.show()
