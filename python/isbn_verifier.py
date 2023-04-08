import re

def is_valid(isbn):
    isbn = isbn.replace('-', '')
    if not re.search(r'^\d{9}(\d|X)$', isbn):
        return False

    acc = 0
    for (i, c) in enumerate(isbn):
        d = c == 'X' and 10 or int(c)
        acc = (acc + d * (10 - i)) % 11

    return acc == 0
