INSERT INTO Kategorie (nazev) VALUES 
('Kola'),
('Helmy'),
('Oblečení');

-- test
CALL PridejPotrebu('Horské kolo', 12000, 1, 5);
CALL PridejPotrebu('Cyklopřilba', 800, 2, 10);

SELECT * FROM SportovniPotreba;
SELECT * FROM Sklad;