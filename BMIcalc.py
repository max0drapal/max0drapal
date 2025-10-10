# BMI Kalkulačka

# Funkce na výpočet BMI
def bmi(vyska, hmotnost):
    return hmotnost / (vyska ** 2)  # vzorec podle zadání

# Funkce na určení kategorie podle BMI
def kategorie_bmi(bmi_hodnota):
    if bmi_hodnota < 18.5:
        return "Podváha"
    elif bmi_hodnota < 25:
        return "Normální váha"
    elif bmi_hodnota < 30:
        return "Nadváha"
    else:
        return "Obezita"

# Načtení údajů od uživatele
vyska = float(input("Zadej výšku v metrech (např. 1.67): "))
hmotnost = float(input("Zadej hmotnost v kilogramech: "))

# Výpočet BMI
bmi_hodnota = bmi(vyska, hmotnost)

# Určení kategorie
kategorie = kategorie_bmi(bmi_hodnota)

# výsledek
print("\n--- Výsledek ---")
print(f"Výška: {vyska} m")
print(f"Hmotnost: {hmotnost} kg")
print(f"Kategorie: {kategorie}")