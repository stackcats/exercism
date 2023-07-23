def factors(value):
    n = 2
    res = []
    while value >= n:
        if value % n == 0:
            value //= n
            res.append(n)
        else:
            n += 1

    return res
