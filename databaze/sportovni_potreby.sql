CREATE DATABASE IF NOT EXISTS SportovniPotreby;
USE SportovniPotreby;

CREATE TABLE Vyrobce (
    vyrobce_id INT PRIMARY KEY AUTO_INCREMENT,
    nazev VARCHAR(100) NOT NULL,
    adresa VARCHAR(200),
    telefon VARCHAR(20),
    email VARCHAR(100),
    datum_vytvoreni TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Kategorie (
    kategorie_id INT PRIMARY KEY AUTO_INCREMENT,
    nazev VARCHAR(50) NOT NULL UNIQUE,
    popis TEXT,
    nadkategorie_id INT NULL,
    FOREIGN KEY (nadkategorie_id) REFERENCES Kategorie(kategorie_id)
);

CREATE TABLE SportovniPotreba (
    potreba_id INT PRIMARY KEY AUTO_INCREMENT,
    nazev VARCHAR(100) NOT NULL,
    popis TEXT,
    cena DECIMAL(10,2) NOT NULL CHECK (cena >= 0),
    velikost VARCHAR(20),
    barva VARCHAR(30),
    vaha DECIMAL(6,2),
    material VARCHAR(50),
    vyrobce_id INT NOT NULL,
    kategorie_id INT NOT NULL,
    datum_pridani TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (vyrobce_id) REFERENCES Vyrobce(vyrobce_id),
    FOREIGN KEY (kategorie_id) REFERENCES Kategorie(kategorie_id)
);

CREATE TABLE Sklad (
    sklad_id INT PRIMARY KEY AUTO_INCREMENT,
    potreba_id INT NOT NULL UNIQUE,
    mnozstvi INT NOT NULL CHECK (mnozstvi >= 0),
    minimalni_mnozstvi INT NOT NULL DEFAULT 0 CHECK (minimalni_mnozstvi >= 0),
    umisteni VARCHAR(50),
    datum_posledni_naskladneni DATE,
    FOREIGN KEY (potreba_id) REFERENCES SportovniPotreba(potreba_id)
);

CREATE INDEX idx_kategorie ON SportovniPotreba(kategorie_id);
CREATE INDEX idx_vyrobce ON SportovniPotreba(vyrobce_id);
CREATE INDEX idx_cena ON SportovniPotreba(cena);

DELIMITER //

CREATE PROCEDURE VlozSportovniPotrebu(
    IN p_nazev VARCHAR(100),
    IN p_popis TEXT,
    IN p_cena DECIMAL(10,2),
    IN p_velikost VARCHAR(20),
    IN p_barva VARCHAR(30),
    IN p_vaha DECIMAL(6,2),
    IN p_material VARCHAR(50),
    IN p_vyrobce_id INT,
    IN p_kategorie_id INT,
    IN p_sklad_mnozstvi INT,
    IN p_minimalni_mnozstvi INT,
    IN p_umisteni VARCHAR(50)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    INSERT INTO SportovniPotreba (
        nazev, popis, cena, velikost, barva, vaha, material, 
        vyrobce_id, kategorie_id
    ) VALUES (
        p_nazev, p_popis, p_cena, p_velikost, p_barva, p_vaha, p_material,
        p_vyrobce_id, p_kategorie_id
    );

    SET @nove_id = LAST_INSERT_ID();

    INSERT INTO Sklad (
        potreba_id, mnozstvi, minimalni_mnozstvi, umisteni, datum_posledni_naskladneni
    ) VALUES (
        @nove_id, p_sklad_mnozstvi, p_minimalni_mnozstvi, p_umisteni, CURDATE()
    );

    COMMIT;
END //

DELIMITER ;

INSERT INTO Vyrobce (nazev, adresa, telefon, email) VALUES
('Sportisimo', 'Pražská 123, Praha', '+420 123 456 789', 'info@sportisimo.cz'),
('Nike', 'Sportovní 456, Brno', '+420 987 654 321', 'obchod@nike.cz'),
('Adidas', 'Třida míru 789, Ostrava', '+420 555 666 777', 'prodej@adidas.cz'),
('Specialized', 'Cyklostezka 111, Plzeň', '+420 222 333 444', 'cz@specialized.com');


INSERT INTO Kategorie (nazev, popis) VALUES
('Oblečení', 'Sportovní oblečení a doplňky'),
('Obuv', 'Sportovní obuv'),
('Kola', 'Horská, silniční a městská kola'),
('Helmy', 'Bezpečnostní helmy'),
('Náčiní', 'Sportovní náčiní a pomůcky');

CALL VlozSportovniPotrebu(
    'Běžecká bota Nike Air',
    'Kvalitní běžecká bota s odpružením',
    2499.00,
    '42',
    'černá/bílá',
    0.35,
    'syntetický materiál',
    2,
    2,
    15,
    5,
    'A-12-3'
);

CALL VlozSportovniPotrebu(
    'Cyklopřilba Rocket', 
    'Lehká cyklistická přilba s odvětráním', 
    899.00, 
    'M', 
    'červená', 
    0.45, 
    'polykarbonát', 
    1, 
    4, 
    8, 
    3, 
    'B-5-2'
);

SELECT 
    sp.potreba_id AS 'ID',
    sp.nazev AS 'Název potřeby',
    sp.cena AS 'Cena',
    k.nazev AS 'Kategorie',
    v.nazev AS 'Výrobce',
    s.mnozstvi AS 'Sklad',
    s.umisteni AS 'Umístění'
FROM SportovniPotreba sp
JOIN Kategorie k ON sp.kategorie_id = k.kategorie_id
JOIN Vyrobce v ON sp.vyrobce_id = v.vyrobce_id
JOIN Sklad s ON sp.potreba_id = s.potreba_id;

SELECT 
    k.nazev AS 'Kategorie',
    COUNT(sp.potreba_id) AS 'Počet produktů',
    SUM(s.mnozstvi) AS 'Celkem na skladě'
FROM Kategorie k
LEFT JOIN SportovniPotreba sp ON k.kategorie_id = sp.kategorie_id
LEFT JOIN Sklad s ON sp.potreba_id = s.potreba_id
GROUP BY k.kategorie_id, k.nazev;

CALL VlozSportovniPotrebu(
    'Testovací produkt - CHYBA',
    'Test rollback funkcionality',
    -100.00,
    'L',
    'modrá',
    1.2,
    'test',
    1,
    1,
    10,
    2,
    'C-1-1'
);

SELECT '=== DATABÁZE ÚSPĚŠNĚ VYTVOŘENA ===' AS Status;
SELECT 'Procedura VlozSportovniPotrebu je připravena k použití' AS Info;
