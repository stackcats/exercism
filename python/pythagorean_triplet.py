def triplets_with_sum(number):
    res = []
    for a in range(1, number // 3 + 1):
        for b in range(a + 1, number // 2 + 1):
            c = number - a - b
            if a + b + c == number and a * a + b * b == c * c:
                res.append([a, b, c])
    return res
