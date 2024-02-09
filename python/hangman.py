STATUS_WIN = "win"
STATUS_LOSE = "lose"
STATUS_ONGOING = "ongoing"


class Hangman:
    def __init__(self, word):
        self.word = word
        self.guessed = set()
        self.remaining_guesses = 9
        self.status = STATUS_ONGOING

    def guess(self, char):
        if self.status != STATUS_ONGOING:
            raise ValueError("The game has already ended.")

        if char in self.word and char not in self.guessed:
            self.guessed.add(char)
            if set(self.word) == self.guessed:
                self.status = STATUS_WIN
            return

        self.remaining_guesses -= 1
        if self.remaining_guesses < 0:
            self.status = STATUS_LOSE

    def get_masked_word(self):
        return "".join([c in self.guessed and c or "_" for c in self.word])

    def get_status(self):
        return self.status
