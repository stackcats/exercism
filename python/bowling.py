class BowlingGame:
    def __init__(self):
        self.rolls = []

    def roll(self, pins):
        assert pins >= 0 and pins <= 10, "pins must in [0, 10]"
        if len(self.rolls) % 2 == 1:
            assert self.rolls[-1] + pins <= 10, "cannot more than 10 points"
        if len(self.rolls) >= 20:
            assert (
                self.rolls[18] + self.rolls[19] == 10
            ), "cannot roll if game already has ten frames"
        if pins == 10:
            self.rolls.append(pins)
            self.rolls.append(0)
            return

        self.rolls.append(pins)

        if len(self.rolls) > 22:
            assert (
                self.rolls[18] == 10 and self.rolls[20] == 10
            ), "cannot roll after bonus rolls for strike"
        if len(self.rolls) > 21:
            assert self.rolls[18] == 10, "cannot roll after bonus roll for spare"

    def score(self):
        s = 0
        for j in range(10):
            i = j * 2
            if self.rolls[i] == 10:
                s += 10 + self.rolls[i + 2]
                if self.rolls[i + 2] == 10:
                    s += self.rolls[i + 4]
                else:
                    s += self.rolls[i + 3]
            elif self.rolls[i] + self.rolls[i + 1] == 10:
                s += 10 + self.rolls[i + 2]
            else:
                s += self.rolls[i] + self.rolls[i + 1]
        return s
