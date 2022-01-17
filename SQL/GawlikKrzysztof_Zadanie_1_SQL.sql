create table T_Student (
	ID_studenta int not null primary key,
	Imie varchar(50) not null,
	Nazwisko varchar(100) not null,
	ID_grupy int not null,
	ID_trybu int not null,
	ID_wydzialu int not null,
	ID_uczelni int not null
);
create table T_Grupa_studencka (
	ID_grupy int not null primary key,
	Nazwa_grupy varchar(100) not null
);
create table T_Rodzaj_studiow (
	ID_trybu int not null primary key,
	Tryb_studiów varchar(30) not null
);
create table T_Wydzial (
	ID_wydzialu int not null primary key,
	Nazwa_wydzialu varchar(150) not null,
	Miejscowosc varchar(100) not null,
	ID_uczelni int not null
);
create table T_Uczelnia (
	ID_uczelni int not null primary key,
	Nazwa_uczelni varchar(150) not null,
	Patron varchar(100) not null
);
alter table T_Student add foreign key (ID_grupy) references T_Grupa_studencka (ID_grupy);
alter table T_Student add foreign key (ID_trybu) references T_Rodzaj_studiow (ID_trybu);
alter table T_Student add foreign key (ID_wydzialu) references T_Wydzial (ID_wydzialu);
alter table T_Student add foreign key (ID_uczelni) references T_Uczelnia (ID_uczelni);
alter table T_Wydzial add foreign key (ID_uczelni) references T_Uczelnia (ID_uczelni);