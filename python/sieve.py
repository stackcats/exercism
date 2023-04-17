def primes(limit):
    if limit < 2:
        return []

    lst = [1] * (limit + 1)

    for i in range(4, limit + 1, 2):
        lst[i] = 0

    for i in range(3, limit + 1, 2):
        k = i + i
        while k <= limit:
            lst[k] = 0
            k += i

    return [i + 2 for (i, n) in enumerate(lst[2:]) if n == 1]
