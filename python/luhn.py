class Luhn:

    def __init__(self, card_num):
        self._card_num = card_num.replace(' ', '')

    def valid(self):
        if len(self._card_num) <= 1:
            return False

        total = 0
        for (i, c) in enumerate(self._card_num[::-1]):
            if not c.isdigit():
                return False
            n = int(c)
            if i % 2 == 1:
                n *= 2
                if n > 9:
                    n -= 9
            total += n
        return total % 10 == 0
