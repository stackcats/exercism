import random
import string
import typing


def generate_name():
    random.seed()
    alphas = random.choices(string.ascii_uppercase, k=2)
    digits = random.choices(string.digits, k=3)
    return ''.join(alphas + digits)


class Robot:
    names: typing.Set[str] = set()

    def __init__(self):
        self.name = self.generate_name()

    def reset(self):
        self.name = self.generate_name()

    def generate_name(self):
        while name := generate_name():
            if name in Robot.names:
                continue
            Robot.names.add(name)
            return name
