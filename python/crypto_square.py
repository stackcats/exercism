import re
import math


def cipher_text(plain_text):
    text = re.sub(r'[^a-zA-Z0-9]', '', plain_text).lower()
    row = round(len(text)**0.5)
    col = row
    if row * row < len(text):
        col = row + 1

    mat = [[' '] * col for _ in range(row)]

    i = 0
    j = 0
    for c in text:
        mat[i][j] = c
        j += 1
        if j == col:
            j = 0
            i += 1

    res = []
    for j in range(col):
        r = ''
        for i in range(row):
            r += mat[i][j]
        res.append(r)
    return ' '.join(res)
