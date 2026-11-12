CREATE TABLE pracownik (
	id_pracownika INT AUTO_INCREMENT PRIMARY KEY,
	imie VARCHAR(40) NOT NULL,
	nazwisko VARCHAR(60) NOT NULL,
	data_urodzenia DATE NOT NULL
);
INSERT INTO pracownik (imie, nazwisko, data_urodzenia)
VALUES 
('Jan', 'Kowalski', '1999-01-01'),
('Piotr', 'Kowalski', '1990-04-03'),
('Wlodzimierz','Bialy','1967-05-30');

UPDATE pracownik
SET data_urodzenia = '2000-01-01'
WHERE id_pracownika = 1;

CREATE TABLE zadanie (
	id_zadania INT AUTO_INCREMENT PRIMARY KEY,
    nazwa_zadania VARCHAR(150) NOT NULL,
	priorytet ENUM('normalny', 'wysoki','niski'),
	opis LONGTEXT,
	pracownik INT,
	FOREIGN KEY (pracownik) REFERENCES pracownik(id_pracownika) ON DELETE SET NULL
);


ALTER TABLE zadanie
MODIFY priorytet ENUM('normalny', 'wysoki','niski') DEFAULT 'normalny';

INSERT INTO zadanie (nazwa_zadania, priorytet, opis, pracownik)
VALUES 
('Przygotowanie raportu', 'wysoki', 'Nalezy przygotowac raport finansowy', 1),
('Audyt systemuw', 'wysoki','Przeglad zabezpieczen serwera', 2),
('Upozadkowanie teczek', 'niski', 'Upozadkowanie wszystkich szuflad', 3);

CREATE TABLE projekt (
	id_projektu INT AUTO_INCREMENT PRIMARY KEY,
    nazwa_projektu VARCHAR(150) NOT NULL,
    data_rozpoczecia DATE NOT NULL,
    data_zakonczenia DATE
);

ALTER TABLE projekt
ADD manager_projektu INT;

ALTER TABLE projekt
ADD CONSTRAINT fk_manager_projektu
FOREIGN KEY (manager_projektu)
REFERENCES pracownik(id_pracownika);

INSERT INTO projekt
(nazwa_projektu, data_rozpoczecia, data_zakonczenia, manager_projektu)
VALUES
('System informatyczny', '2026-01-01','2026-06-30'),
('Strona internetowa', '2026-01-03','2026-08-30');

ALTER TABLE zadanie
ADD CONSTRAINT fk_zadanie_projekt
FOREIGN KEY (projekt)
REFERENCES projekt(id_projektu)
ON DELETE CASCADE;

UPDATE zadanie
SET projekt = 1
WHERE id_zadania = 1;

UPDATE zadanie
SET projekt = 2
WHERE id_zadania = 2;

UPDATE zadanie
SET projekt = 1
WHERE id_zadania = 3;


