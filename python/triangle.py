def is_triangle(sides):
    [a, b, c] = sorted(sides)
    return a > 0 and a + b >= c


def size(sides):
    return len(set(sides))


def equilateral(sides):
    return is_triangle(sides) and size(sides) == 1


def isosceles(sides):
    return is_triangle(sides) and size(sides) != 3


def scalene(sides):
    return is_triangle(sides) and size(sides) == 3
