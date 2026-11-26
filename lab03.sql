
-- ZADANIE 1

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
    ('Włodzimierz', 'Biały', '1967-05-30');

UPDATE pracownik
SET data_urodzenia = '2000-01-01'
WHERE id_pracownika = 1;



-- ZADANIE 2

CREATE TABLE zadanie (
    id_zadania INT AUTO_INCREMENT PRIMARY KEY,
    nazwa_zadania VARCHAR(150) NOT NULL,
    priorytet ENUM('normalny', 'wysoki', 'niski'),
    opis LONGTEXT,
    pracownik INT,
    FOREIGN KEY (pracownik) REFERENCES pracownik(id_pracownika) ON DELETE SET NULL
);

ALTER TABLE zadanie
MODIFY priorytet ENUM('normalny', 'wysoki', 'niski') DEFAULT 'normalny';

INSERT INTO zadanie (nazwa_zadania, priorytet, opis, pracownik)
VALUES 
    ('Przygotowanie raportu', 'wysoki', 'Należy przygotować raport finansowy', 1),
    ('Audyt systemów', 'wysoki', 'Przegląd zabezpieczeń serwera', 2),
    ('Uporządkowanie teczek', 'niski', 'Uporządkowanie wszystkich szuflad', 3);



-- ZADANIE 3

CREATE TABLE projekt (
    id_projektu INT AUTO_INCREMENT PRIMARY KEY,
    nazwa_projektu VARCHAR(150) NOT NULL,
    data_rozpoczecia DATE NOT NULL,
    data_zakonczenia DATE
);


ALTER TABLE projekt
ADD menadzer_projektu INT;

ALTER TABLE projekt
ADD CONSTRAINT fk_menadzer_projektu
FOREIGN KEY (menadzer_projektu)
REFERENCES pracownik(id_pracownika);


INSERT INTO projekt (nazwa_projektu, data_rozpoczecia, data_zakonczenia, menadzer_projektu)
VALUES
    ('System informatyczny', '2026-01-01', '2026-06-30', 1),
    ('Strona internetowa', '2026-01-03', '2026-08-30', 2);


ALTER TABLE zadanie
ADD projekt INT;

ALTER TABLE zadanie
ADD CONSTRAINT fk_zadanie_projekt
FOREIGN KEY (projekt)
REFERENCES projekt(id_projektu)
ON DELETE CASCADE;

UPDATE zadanie SET projekt = 1 WHERE id_zadania = 1;
UPDATE zadanie SET projekt = 2 WHERE id_zadania = 2;
UPDATE zadanie SET projekt = 1 WHERE id_zadania = 3;



-- ZADANIE 4

CREATE TABLE sprint (
    id_sprintu INT AUTO_INCREMENT PRIMARY KEY, 
    numer_sprintu INT UNSIGNED,
    data_rozpoczecia DATE,
    data_zakonczenia DATE
);

ALTER TABLE zadanie
ADD sprint INT;

ALTER TABLE zadanie
ADD CONSTRAINT fk_zadanie_sprint
FOREIGN KEY (sprint)
REFERENCES sprint(id_sprintu)
ON DELETE SET NULL;

INSERT INTO sprint (numer_sprintu, data_rozpoczecia, data_zakonczenia)
VALUES (1, '2026-03-01', '2026-03-14');

UPDATE zadanie
SET sprint = 1
WHERE id_zadania IN (1, 2);



-- ZADANIE 5

CREATE TABLE status (
    id_statusu INT AUTO_INCREMENT PRIMARY KEY, 
    nazwa_statusu VARCHAR(20)
);

INSERT INTO status (nazwa_statusu)
VALUES
    ('Nowe'),
    ('W trakcie'),
    ('Zakończone');

CREATE TABLE zadanie_has_status (
    id_zdarzenia INT AUTO_INCREMENT PRIMARY KEY,
    id_zadania INT,
    id_statusu INT,
    data_zdarzenia DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_zadania) REFERENCES zadanie(id_zadania) ON DELETE CASCADE,
    FOREIGN KEY (id_statusu) REFERENCES status(id_statusu)
);
    
INSERT INTO zadanie_has_status (id_zadania, id_statusu)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);


DELETE FROM projekt
WHERE id_projektu = 2;


SELECT * FROM zadanie;


ALTER TABLE zadanie
DROP FOREIGN KEY fk_zadanie_sprint;

ALTER TABLE zadanie
DROP COLUMN sprint;

DROP TABLE sprint;



