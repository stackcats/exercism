import random


class Character:

    def __init__(self):
        self.strength = self.ability()
        self.dexterity = self.ability()
        self.constitution = self.ability()
        self.intelligence = self.ability()
        self.wisdom = self.ability()
        self.charisma = self.ability()
        self.hitpoints = 10 + modifier(self.constitution)

    def ability(self):
        arr = [random.randint(1, 6) for _ in range(6)]
        return sum(sorted(arr, reverse=True)[:3])


def modifier(n):
    return (n - 10) // 2
