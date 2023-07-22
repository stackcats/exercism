def decode(string: str) -> str:
    ct = 0
    dst = ''
    for c in string:
        if c.isdigit():
            ct = ct * 10 + int(c)
        else:
            if ct == 0:
                dst += c
            else:
                dst += c * ct
            ct = 0

    return dst


def encode(string: str) -> str:
    dst = ''
    prev = ''
    ct = 1
    for c in string:
        if c == prev:
            ct += 1
        else:
            if ct == 1:
                dst += prev
            else:
                dst += f'{ct}{prev}'
            prev = c
            ct = 1

    if ct == 1:
        dst += prev
    else:
        dst += f'{ct}{prev}'
    return dst
