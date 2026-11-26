-- ZADANIE 1

ALTER TABLE zadanie
DROP FOREIGN KEY zadanie_ibfk_1;

ALTER TABLE projekt
DROP FOREIGN KEY fk_menadzer_projektu;


ALTER TABLE pracownik
MODIFY id_pracownika INT NOT NULL;

ALTER TABLE pracownik
DROP PRIMARY KEY; 

ALTER TABLE pracownik
ADD PRIMARY KEY (id_pracownika);

ALTER TABLE pracownik
MODIFY id_pracownika INT AUTO_INCREMENT;

ALTER TABLE zadanie
ADD CONSTRAINT fk_zadanie_pracownik
FOREIGN KEY (pracownik) REFERENCES pracownik(id_pracownika)
ON DELETE SET NULL;

ALTER TABLE projekt
ADD CONSTRAINT fk_menadzer_projektu
FOREIGN KEY (menadzer_projektu) REFERENCES pracownik(id_pracownika);