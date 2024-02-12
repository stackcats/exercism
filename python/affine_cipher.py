import math


def encode(plain_text, a, b):
    if math.gcd(a, 26) != 1:
        raise ValueError("a and m must be coprime.")

    s = ""
    ct = 0
    for c in plain_text:
        if c.isdigit():
            t = c
        else:
            if not c.isalpha():
                continue
            i = ord(c.lower()) - ord("a")
            t = chr((a * i + b) % 26 + ord("a"))

        if ct > 0 and ct % 5 == 0:
            s += " "
        s += t
        ct += 1

    return s


def mmi(a, m):
    for x in range(m):
        if a * x % m == 1:
            return x


def decode(ciphered_text, a, b):
    if math.gcd(a, 26) != 1:
        raise ValueError("a and m must be coprime.")

    s = ""
    for c in ciphered_text:
        if c == " ":
            continue
        if c.isdigit():
            s += c
        else:
            y = ord(c) - ord("a")
            s += chr(mmi(a, 26) * (y - b) % 26 + ord("a"))
    return s
