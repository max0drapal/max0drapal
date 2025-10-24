DELIMITER //

CREATE PROCEDURE PridejPotrebu(
    IN p_nazev VARCHAR(200),
    IN p_cena DECIMAL(10,2),
    IN p_kategorie_id INT,
    IN p_mnozstvi INT
)
BEGIN
    -- proměnná pro chybu
    DECLARE exit_handler BOOLEAN DEFAULT FALSE;
    
    -- handler pro chybu
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET exit_handler = TRUE;
    END;

    -- začátek transakce
    START TRANSACTION;
    
    -- vložení sportovních potřeb
    INSERT INTO SportovniPotreba (nazev, cena, kategorie_id)
    VALUES (p_nazev, p_cena, p_kategorie_id);
    
    -- vložení do skladu
    INSERT INTO Sklad (potreba_id, mnozstvi)
    VALUES (LAST_INSERT_ID(), p_mnozstvi);
    
    -- kontrola chyb
    IF exit_handler THEN
        ROLLBACK;
        SELECT 'CHYBA: Něco se pokazilo' AS vysledek;
    ELSE
        COMMIT;
        SELECT 'OK: Potřeba byla přidána' AS vysledek;
    END IF;
    
END//

DELIMITER ;