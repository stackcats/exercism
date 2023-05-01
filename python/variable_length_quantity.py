def encode(numbers):
    res = []
    for n in numbers[::-1]:
        if n == 0:
            res.append(0)
            continue

        h = 0
        while n > 0:
            d = n & 0x7F | h
            h |= 0x80
            n >>= 7
            res.append(d)

    return res[::-1]


def decode(bytes_):
    res = []
    n = 0
    is_complete = False
    for b in bytes_:
        n += b & 0x7F
        if b >> 7 == 0:
            is_complete = True
            res.append(n)
            n = 0
        else:
            is_complete = False
            n <<= 7
    if not is_complete:
        raise ValueError('incomplete sequence')
    return res
