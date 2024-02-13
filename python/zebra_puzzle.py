from itertools import permutations

colors = ["red", "green", "ivory", "yellow", "blue"]
drinks = ["tea", "milk", "water", "juice", "coffee"]
pets = ["dog", "snails", "fox", "zebra", "horse"]
smokes = ["Old Gold", "Kools", "Chesterfields", "Lucky Strike", "Parliaments"]
nationalities = ["Englishman", "Spaniard", "Ukrainian", "Norwegian", "Japanese"]

solution = next(
    list(zip(color, drink, pet, smoke, nationality))
    for color in permutations(colors)
    # 6
    if color.index("green") - color.index("ivory") == 1
    for nationality in permutations(nationalities)
    # 2
    if color.index("red") == nationality.index("Englishman")
    # 15
    if abs(color.index("blue") - nationality.index("Norwegian")) == 1
    for drink in permutations(drinks)
    # 9
    if drink.index("milk") == 2
    # 4
    if drink.index("coffee") == color.index("green")
    # 10
    if nationality.index("Norwegian") == 0
    # 5
    if nationality.index("Ukrainian") == drink.index("tea")
    for pet in permutations(pets)
    # 3
    if pet.index("dog") == nationality.index("Spaniard")
    for smoke in permutations(smokes)
    # 7
    if smoke.index("Old Gold") == pet.index("snails")
    # 8
    if smoke.index("Kools") == color.index("yellow")
    # 11
    if abs(pet.index("fox") - smoke.index("Chesterfields")) == 1
    # 12
    if abs(pet.index("horse") - smoke.index("Kools")) == 1
    # 13
    if smoke.index("Lucky Strike") == drink.index("juice")
    # 14
    if nationality.index("Japanese") == smoke.index("Parliaments")
)


def drinks_water():
    return [house for house in solution if house[1] == "water"][0][-1]


def owns_zebra():
    return [house for house in solution if house[2] == "zebra"][0][-1]
