-- Selekce všech vlastníků z tabulky owners seřazených vzestupně podle příjmení.

| id | first_name | last_name   | birthday   | city    | street  | house_number | zip_code |
|----|------------|-------------|------------|---------|---------|--------------|----------|
|  4 | Josef      | Král        | 1968-04-17 | Plze?   | Kratká  | 8            | 30100    |
|  1 | Jan        | Novák       | 1980-05-15 | Praha   | Dlouhá  | 12           | 11000    |
|  5 | Eva        | Procházková | 1985-09-02 | Liberec | St?ední | 14           | 46001    |
|  2 | Petr       | Svoboda     | 1975-11-21 | Brno    | Široká  | 3            | 60200    |
|  3 | Anna       | Veselá      | 1990-08-10 | Ostrava | Nová    | 45           | 70030    |

  -- Selekce všech všech vlastníků z tabulky owners, kteří se narodili po roce 1980.
  
| id | first_name | last_name   | birthday   | city    | street  | house_number | zip_code |
|----|------------|-------------|------------|---------|---------|--------------|----------|
|  3 | Anna       | Veselá      | 1990-08-10 | Ostrava | Nová    | 45           | 70030    |
|  5 | Eva        | Procházková | 1985-09-02 | Liberec | St?ední | 14           | 46001    |

-- Selekce všech vlastníků z tabulky owners, kteří pocházejí z města, jehož název začíná písmenem P

| id | first_name | last_name | birthday   | city  | street | house_number | zip_code |
|----|------------|-----------|------------|-------|--------|--------------|----------|
|  1 | Jan        | Novák     | 1980-05-15 | Praha | Dlouhá | 12           | 11000    |
|  4 | Josef      | Král      | 1968-04-17 | Plze? | Kratká | 8            | 30100    |

-- Selekce počtu všech jedinečných modelů (DISTINCT) z tabulky models.

| model_amount |
|--------------|
|           10 |

-- Selekce všech VIN kódů (projekce) z tabulky vehicles.

| vin_code          |
|-------------------|
| 1FAFP404X1F123456 |
| 1HGCM82633A123456 |
| 2HGFB2F50DH123456 |
| 3VWFE21C04M000001 |
| 4T1BG22K51U123456 |
