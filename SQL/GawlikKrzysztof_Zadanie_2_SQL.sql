-- UTWÓRZ TABELE
create table T_Osoba (
	ID_osoby int not null primary key,
    Imie varchar(20) not null,
    Nazwisko varchar(30) not null,
    ID_rodzaju_zatrudnienia varchar(5) not null
);
create table T_Ksiazka (
	ID_ksiazki int not null primary key,
    ID_dzialu int not null,
    ID_rodzaju varchar(5) not null,
    ID_biblioteki varchar(10) not null,
    Autor varchar(20) not null,
    Tytul varchar(100) not null,
    Rok_wydania int
);
create table T_Rodzaj_zatrudnienia (
	ID_rodzaju_zatrudnienia varchar(5) not null primary key unique,
    Rodzaj varchar(30) not null
);
create table T_Rodzaj_ksiazki (
	ID_rodzaju_ksiazki varchar(5) not null primary key unique,
    Gatunek varchar(50) not null
);
create table T_Biblioteka (
	ID_biblioteki varchar(10) not null primary key unique,
    Nazwa varchar(50) not null,
    Miasto varchar(50) not null
);
create table T_Wypozyczenia (
    ID_wypozyczenia int not null primary key,
    Data_wypozyczenia date not null,
    Okres_wypozyczenia_dni int not null,
    ID_osoby_wypozyczajacej int not null,
    ID_ksiazki int not null
);
create table T_Dzialy_w_bibliotece (
    ID_dzialu int not null primary key,
    Nazwa varchar(30) not null
);
-- UTWÓRZ RELACJE
alter table T_Wypozyczenia add foreign key (ID_osoby_wypozyczajacej) references T_Osoba (ID_osoby);
alter table T_Osoba add foreign key (ID_rodzaju_zatrudnienia) references T_Rodzaj_zatrudnienia (ID_rodzaju_zatrudnienia);
alter table T_Wypozyczenia add foreign key (ID_ksiazki) references T_Ksiazka (ID_ksiazki);
alter table T_Ksiazka add foreign key (ID_dzialu) references T_Dzialy_w_bibliotece (ID_dzialu);
alter table T_Ksiazka add foreign key (ID_rodzaju) references T_Rodzaj_ksiazki (ID_rodzaju_ksiazki);
alter table T_Ksiazka add foreign key (ID_biblioteki) references T_Biblioteka (ID_biblioteki);
-- ZAIMPORTUJ DANE
insert into T_Dzialy_w_bibliotece (ID_dzialu, Nazwa) values (1, "Polskie");
insert into T_Dzialy_w_bibliotece (ID_dzialu, Nazwa) values (2, "Zagraniczne");
insert into T_Rodzaj_zatrudnienia (ID_rodzaju_zatrudnienia, Rodzaj) values ("Kli", "Klient");
insert into T_Rodzaj_zatrudnienia (ID_rodzaju_zatrudnienia, Rodzaj) values ("UoP", "Umowa o prace");
insert into T_Biblioteka (ID_biblioteki, Nazwa, Miasto) values ("KRA1STM1", "Biblioteka Stare Miasto", "Kraków");
insert into T_Rodzaj_ksiazki (ID_rodzaju_ksiazki, Gatunek) values ("FN", "Fantastyka Naukowa");
insert into T_Rodzaj_ksiazki (ID_rodzaju_ksiazki, Gatunek) values ("SELFD", "Samorozwoj");
insert into T_Rodzaj_ksiazki (ID_rodzaju_ksiazki, Gatunek) values ("ERO", "Erotyka");
insert into T_Osoba (ID_osoby, Imie, Nazwisko, ID_rodzaju_zatrudnienia) values (1, "Jan", "Kowalski", "UoP");
insert into T_Osoba (ID_osoby, Imie, Nazwisko, ID_rodzaju_zatrudnienia) values (2, "Wojciech", "Niemiec", "Kli");
insert into T_Osoba (ID_osoby, Imie, Nazwisko, ID_rodzaju_zatrudnienia) values (3, "Julian", "Wywer", "Kli");
insert into T_Ksiazka (ID_ksiazki, ID_dzialu, ID_rodzaju, ID_biblioteki, Autor, Tytul, Rok_wydania) values (1, 1, "ERO", "KRA1STM1", "Julian Tuwim", "Mokre doły", 1920);
insert into T_Ksiazka (ID_ksiazki, ID_dzialu, ID_rodzaju, ID_biblioteki, Autor, Tytul, Rok_wydania) values (2, 1, "FN", "KRA1STM1", "Mateusz Sroka", "Kreatywna burza", 2005);
insert into T_Ksiazka (ID_ksiazki, ID_dzialu, ID_rodzaju, ID_biblioteki, Autor, Tytul, Rok_wydania) values (3, 2, "SELFD", "KRA1STM1", "Mateusz Sroka", "Communication", 2015);
insert into T_Wypozyczenia (ID_wypozyczenia, Data_wypozyczenia, Okres_wypozyczenia_dni, ID_osoby_wypozyczajacej, ID_ksiazki) values (1, "5.01.2022", 7, 2, 2);
insert into T_Wypozyczenia (ID_wypozyczenia, Data_wypozyczenia, Okres_wypozyczenia_dni, ID_osoby_wypozyczajacej, ID_ksiazki) values (2, "5.01.2022", 14, 3, 3);
insert into T_Wypozyczenia (ID_wypozyczenia, Data_wypozyczenia, Okres_wypozyczenia_dni, ID_osoby_wypozyczajacej, ID_ksiazki) values (3, "6.01.2022", 7, 1, 1);
insert into T_Wypozyczenia (ID_wypozyczenia, Data_wypozyczenia, Okres_wypozyczenia_dni, ID_osoby_wypozyczajacej, ID_ksiazki) values (4, "6.01.2022", 14, 1, 3);
insert into T_Wypozyczenia (ID_wypozyczenia, Data_wypozyczenia, Okres_wypozyczenia_dni, ID_osoby_wypozyczajacej, ID_ksiazki) values (5, "6.01.2022", 14, 2, 3);
insert into T_Wypozyczenia (ID_wypozyczenia, Data_wypozyczenia, Okres_wypozyczenia_dni, ID_osoby_wypozyczajacej, ID_ksiazki) values (6, "7.01.2022", 30, 2, 1);
-- UTWÓRZ KWERENDĘ
select 
T_Biblioteka.Nazwa as Biblioteka, 
T_Biblioteka.Miasto as Miasto, 
T_Wypozyczenia.ID_wypozyczenia as ID_wypozyczenia, 
T_Wypozyczenia.Data_wypozyczenia as Data, 
T_Osoba.Imie as Imie_klienta, 
T_Osoba.Nazwisko as Nazwisko_klienta, 
T_Ksiazka.Tytul as Tytul_ksiazki, 
T_Ksiazka.Autor as Autor_ksiazki 
from 
T_Biblioteka, 
T_Wypozyczenia, 
T_Osoba, 
T_Ksiazka 
where 
T_Wypozyczenia.Data_wypozyczenia = #1/6/2022# and 
T_Wypozyczenia.ID_osoby_wypozyczajacej = T_Osoba.ID_osoby and 
T_Wypozyczenia.ID_ksiazki = T_Ksiazka.ID_ksiazki and 
T_Ksiazka.ID_biblioteki = T_Biblioteka.ID_biblioteki;
