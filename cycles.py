# Čísla a jejich vlastnosti

# Funkce na zjištění, zda je číslo prvočíslo
def je_prvocislo(cislo):
    if cislo < 2:     # čísla menší než 2 nejsou prvočísla
        return False
    for i in range(2, int(cislo ** 0.5) + 1):  # dělitele do odmocniny
        if cislo % i == 0:  # pokud je dělitelné, není prvočíslo
            return False
    return True

# vstupu
n = int(input("Zadej celé číslo n (větší než 0): "))

# počty
pocet_sudych = 0
pocet_lichych = 0
pocet_prvocisel = 0

# Výpis čísel od 1 do n
for cislo in range(1, n + 1):
    print(f"\nČíslo: {cislo}")

    # Je číslo sudé nebo liché?
    if cislo % 2 == 0:
        print(" - sudé")
        pocet_sudych += 1
    else:
        print(" - liché")
        pocet_lichych += 1

    # Je číslo dělitelné 3?
    if cislo % 3 == 0:
        print(" - dělitelné 3")

    # Je číslo prvočíslo?
    if je_prvocislo(cislo):
        print(" - prvočíslo")
        pocet_prvocisel += 1

# Souhrn na konci
print("\n--- Souhrn ---")
print(f"Počet sudých čísel: {pocet_sudych}")
print(f"Počet lichých čísel: {pocet_lichych}")
print(f"Počet prvočísel: {pocet_prvocisel}")
