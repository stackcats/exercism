import math


class Rational:

    def __init__(self, numer, denom):
        sign = numer * denom < 0 and -1 or 1
        numer = abs(numer)
        denom = abs(denom)
        g = math.gcd(numer, denom)
        self.numer = numer * sign // g
        self.denom = denom // g

    def __eq__(self, other):
        return self.numer == other.numer and self.denom == other.denom

    def __repr__(self):
        return f'{self.numer}/{self.denom}'

    def __add__(self, other):
        return Rational(
            self.numer * other.denom + self.denom * other.numer,
            self.denom * other.denom,
        )

    def __sub__(self, other):
        return Rational(
            self.numer * other.denom - self.denom * other.numer,
            self.denom * other.denom,
        )

    def __mul__(self, other):
        return Rational(
            self.numer * other.numer,
            self.denom * other.denom,
        )

    def __truediv__(self, other):
        return Rational(
            self.numer * other.denom,
            self.denom * other.numer,
        )

    def __abs__(self):
        return Rational(
            abs(self.numer),
            abs(self.denom),
        )

    def __pow__(self, power):
        if power > 0:
            return Rational(
                self.numer**power,
                self.denom**power,
            )
        else:
            return Rational(
                self.denom**(-power),
                self.numer**(-power),
            )

    def __rpow__(self, base):
        return math.pow(base**self.numer, 1 / self.denom)
