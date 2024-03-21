CREATE TABLE Gatunek (
    IdGatunek INT PRIMARY KEY,
    PokazUkryj VARCHAR(255)
);

CREATE TABLE Autor (
    IdAutor INT PRIMARY KEY,
    Imie VARCHAR(255),
    Nazwisko VARCHAR(255),
    Pseudonim VARCHAR(255)
);

CREATE TABLE Wydawnictwo (
    IdWydawnictwo INT PRIMARY KEY,
    Nazwa VARCHAR(255),
    Status VARCHAR(255)
);

CREATE TABLE Recenzja (
    IdRecenzja INT PRIMARY KEY,
    Ocena INT,
    Tresc TEXT,
    UserName VARCHAR(255),
    Ukryj VARCHAR(255)
);

CREATE TABLE Ksiazka (
    IdKsiazka INT PRIMARY KEY,
    IdAutor INT,
    IdGatunek INT,
    Opis TEXT,
    IdRecenzja INT,
    RokWydania INT,
    IdWydawnictwo INT,
    Status VARCHAR(255),
    FOREIGN KEY (IdAutor) REFERENCES Autor(IdAutor),
    FOREIGN KEY (IdGatunek) REFERENCES Gatunek(IdGatunek),
    FOREIGN KEY (IdRecenzja) REFERENCES Recenzja(IdRecenzja),
    FOREIGN KEY (IdWydawnictwo) REFERENCES Wydawnictwo(IdWydawnictwo)
);

CREATE TABLE Egzemplarz (
    IdEgzemplarz INT PRIMARY KEY,
    IdKsiazka INT,
    Status VARCHAR(255),
    IdBiblioteka INT,
    Zuzycie FLOAT,
    FOREIGN KEY (IdKsiazka) REFERENCES Ksiazka(IdKsiazka)
);

CREATE TABLE Lokalizacja (
    IdLokalizacja INT PRIMARY KEY,
    Miasto VARCHAR(255),
    KodPocztowy VARCHAR(255),
    Wojewodztwo VARCHAR(255)
);

CREATE TABLE GodzinyOtwarcia (
    IdGodzinyOtwarcia INT PRIMARY KEY,
    IdBiblioteka INT,
    DzienTygodnia VARCHAR(255),
    Godziny VARCHAR(255),
    Status VARCHAR(255),
    FOREIGN KEY (IdBiblioteka) REFERENCES Biblioteka(IdBiblioteka)
);

CREATE TABLE Biblioteka (
    IdBiblioteka INT PRIMARY KEY,
    IdLokalizacja INT,
    IdGodzinyOtwarcia INT,
    Nazwa VARCHAR(255),
    KeyField VARCHAR(255),
    FOREIGN KEY (IdLokalizacja) REFERENCES Lokalizacja(IdLokalizacja),
    FOREIGN KEY (IdGodzinyOtwarcia) REFERENCES GodzinyOtwarcia(IdGodzinyOtwarcia)
);

CREATE TABLE Uzytkownik (
    IdUzytkownik INT PRIMARY KEY,
    Status VARCHAR(255),
    Login VARCHAR(255),
    Typ VARCHAR(255),
    Nazwisko VARCHAR(255),
    Imie VARCHAR(255),
    IndeksPW VARCHAR(255),
    Wypozyczenie VARCHAR(255),
    Sms VARCHAR(255),
    Mail VARCHAR(255)
);

CREATE TABLE Zamowienie (
    IdZamowienie INT PRIMARY KEY,
    IdEgzemplarz INT,
    IdUzytkownik INT,
    Wypozyczenie VARCHAR(255),
    Data DATE,
    CzasOdbioru TIME,
    FOREIGN KEY (IdEgzemplarz) REFERENCES Egzemplarz(IdEgzemplarz),
    FOREIGN KEY (IdUzytkownik) REFERENCES Uzytkownik(IdUzytkownik)
);

CREATE TABLE Przedluzenie (
    IdPrzedluzenie INT PRIMARY KEY,
    IdWypozyczenie INT,
    Typ VARCHAR(255),
    CzasPrzedluzenia INT,
    FOREIGN KEY (IdWypozyczenie) REFERENCES Wypozyczenie(IdWypozyczenie)
);

CREATE TABLE Notyfikacja (
    IdNotyfikacja INT PRIMARY KEY,
    IdPrzedluzenie INT,
    Tresc TEXT,
    Typ VARCHAR(255),
    IdUzytkownik INT,
    FOREIGN KEY (IdPrzedluzenie) REFERENCES Przedluzenie(IdPrzedluzenie),
    FOREIGN KEY (IdUzytkownik) REFERENCES Uzytkownik(IdUzytkownik)
);

CREATE TABLE Wypozyczenie (
    IdWypozyczenie INT PRIMARY KEY,
    IdZamowienie INT,
    IdEgzemplarz INT,
    DataWypozyczenia DATE,
    CzasWypozyczenia TIME,
    DataZwrotu DATE,
    IdPrzedluzenie INT,
    FOREIGN KEY (IdZamowienie) REFERENCES Zamowienie(IdZamowienie),
    FOREIGN KEY (IdEgzemplarz) REFERENCES Egzemplarz(IdEgzemplarz),
    FOREIGN KEY (IdPrzedluzenie) REFERENCES Przedluzenie(IdPrzedluzenie)
);

CREATE TABLE Config (
    IdConfig INT PRIMARY KEY,
    Nazwa VARCHAR(255),
    Wartosc VARCHAR(255),
    DataModyfikacji DATE,
    DataDodania DATE
);
