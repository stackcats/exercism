from functools import reduce


def largest_product(series, size):
    if series == '':
        raise ValueError('span must be smaller than string length')

    if size < 0:
        raise ValueError('span must not be negative')

    if size > len(series):
        raise ValueError('span must be smaller than string length')

    try:
        lst = [int(c) for c in series]
    except Exception as e:
        raise ValueError('digits input must only contain digits')

    ans = 0
    for i in range(len(lst) - size + 1):
        ans = max(ans, reduce(lambda a, b: a * b, lst[i:i + size]))

    return ans
