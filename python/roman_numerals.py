def roman(number):
    letters = [('I', 'V', 'X'), ('X', 'L', 'C'), ('C', 'D', 'M'),
               ('M', 'M', 'M')]

    res = ''
    while number > 0:
        (l, v, x), *rest = letters
        d = number % 10
        if d == 0:
            pass
        elif d in [1, 2, 3]:
            res = l * d + res
        elif d == 4:
            res = l + v + res
        elif d == 5:
            res = v + res
        elif d in [6, 7, 8]:
            res = v + l * (d - 5) + res
        else:
            res = l + x + res
        letters = rest
        number //= 10
    return res
