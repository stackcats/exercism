COLOR_MAP = {
    "black": 0,
    "brown": 1,
    "red": 2,
    "orange": 3,
    "yellow": 4,
    "green": 5,
    "blue": 6,
    "violet": 7,
    "grey": 8,
    "white": 9,
}


def value(colors: [str]) -> int:
    a, b, *rest = colors
    return COLOR_MAP[a] * 10 + COLOR_MAP[b]


def label(colors: [str]) -> str:
    n = value(colors[:2])
    zeros = COLOR_MAP[colors[2]]
    if n > 0 and n % 10 == 0:
        zeros += 1
        n //= 10

    metrics = [
        ' ohms', '0 ohms', '00 ohms', ' kiloohms', '0 kiloohms', '00 kiloohms',
        ' megaohms', '0 megaohms', '00 megaohms', ' gigaohms'
    ]

    return f'{n}{metrics[zeros]}'
