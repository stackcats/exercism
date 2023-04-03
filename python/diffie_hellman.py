from random import randint


def private_key(p: int) -> int:
    return randint(1, p - 1)


def public_key(p: int, g: int, private: int) -> int:
    return g ** private % p


def secret(p: int, public: int, private: int) -> int:
    return public ** private % p
