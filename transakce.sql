-- Vytvoření tabulky hockeyPlayer
CREATE TABLE hockeyPlayer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fname VARCHAR(30) NOT NULL,   -- křestní jméno hráče
    lname VARCHAR(50) NOT NULL,   -- příjmení hráče
    team VARCHAR(50) NOT NULL     -- tým hráče
);

DELIMITER //

CREATE PROCEDURE insert_player(
    IN p_fname VARCHAR(30),
    IN p_lname VARCHAR(50),
    IN p_team VARCHAR(50)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;   -- vrátí změny zpět
        SELECT 'Chyba při vkládání záznamu' AS zprava;
    END;

    START TRANSACTION;  -- začátek transakce
    INSERT INTO hockeyPlayer (fname, lname, team)
    VALUES (p_fname, p_lname, p_team);
    COMMIT;  -- potvrzení změn
END//

DELIMITER ;

CALL insert_player('David', 'Pastrňák', 'Boston Bruins');
-- → Záznam se vloží do tabulky

CALL insert_player('Pavel', 'Zacha', NULL);
-- → Dojde k chybě, protože sloupec team nesmí být NULL
-- → Provede se ROLLBACK a zobrazí se zpráva "Chyba při vkládání záznamu"
-- → Nic se do tabulky nevloží
