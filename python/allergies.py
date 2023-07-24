MAP = {
    'eggs': 1,
    'peanuts': 2,
    'shellfish': 4,
    'strawberries': 8,
    'tomatoes': 16,
    'chocolate': 32,
    'pollen': 64,
    'cats': 128,
}


class Allergies:

    def __init__(self, score: int):
        self.score = score

    def allergic_to(self, item: str) -> bool:
        return self.score & MAP[item] != 0

    @property
    def lst(self):
        return [k for (k, v) in MAP.items() if v & self.score]
