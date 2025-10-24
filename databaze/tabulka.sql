CREATE DATABASE SportovniPotreby;
USE SportovniPotreby;

-- tabulka kategorií
CREATE TABLE Kategorie (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nazev VARCHAR(100) NOT NULL
);

-- tabulka sportovních potřeb
CREATE TABLE SportovniPotreba (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nazev VARCHAR(200) NOT NULL,
    cena DECIMAL(10,2) NOT NULL,
    kategorie_id INT NOT NULL,
    FOREIGN KEY (kategorie_id) REFERENCES Kategorie(id)
);

-- tabulka skladu
CREATE TABLE Sklad (
    id INT AUTO_INCREMENT PRIMARY KEY,
    potreba_id INT NOT NULL,
    mnozstvi INT NOT NULL,
    FOREIGN KEY (potreba_id) REFERENCES SportovniPotreba(id)
);