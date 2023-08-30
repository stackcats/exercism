import math


class ComplexNumber:

    def __init__(self, real, imaginary):
        self.real = real
        self.imaginary = imaginary

    def __eq__(self, other):
        return (self.real, self.imaginary) == (other.real, other.imaginary)

    def __add__(self, other):
        if isinstance(other, (int, float)):
            other = ComplexNumber(other, 0)
        return ComplexNumber(self.real + other.real,
                             self.imaginary + other.imaginary)

    def __radd__(self, other):
        return self.__add__(other)

    def __mul__(self, other):
        if isinstance(other, (int, float)):
            other = ComplexNumber(other, 0)
        return ComplexNumber(
            self.real * other.real - self.imaginary * other.imaginary,
            self.imaginary * other.real + self.real * other.imaginary,
        )

    def __rmul__(self, other):
        return self.__mul__(other)

    def __sub__(self, other):
        if isinstance(other, (int, float)):
            other = ComplexNumber(other, 0)
        return ComplexNumber(self.real - other.real,
                             self.imaginary - other.imaginary)

    def __rsub__(self, other):
        if isinstance(other, (int, float)):
            other = ComplexNumber(other, 0)
        return ComplexNumber(other.real - self.real,
                             other.imaginary - self.imaginary)

    def __truediv__(self, other):
        if isinstance(other, (int, float)):
            return ComplexNumber(self.real / other, self.imaginary / other)

        d = other.real**2 + other.imaginary**2
        return ComplexNumber(
            (self.real * other.real + self.imaginary * other.imaginary) / d,
            (self.imaginary * other.real - self.real * other.imaginary) / d,
        )

    def __rtruediv__(self, other):
        d = self.real**2 + self.imaginary**2
        if isinstance(other, (int, float)):
            return ComplexNumber(other * self.real / d,
                                 -other * self.imaginary / d)

        return ComplexNumber(
            (self.real * other.real + self.imaginary * other.imaginary) / d,
            (self.real * other.imaginary - self.imaginary * other.real) / d,
        )

    def __abs__(self):
        return (self.real**2 + self.imaginary**2)**0.5

    def conjugate(self):
        return ComplexNumber(self.real, -self.imaginary)

    def exp(self):
        er = math.e**self.real
        return ComplexNumber(er * math.cos(self.imaginary),
                             er * math.sin(self.imaginary))
