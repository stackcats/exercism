from typing import List

COLOR_MAP = {
    'black': 0,
    'brown': 1,
    'red': 2,
    'orange': 3,
    'yellow': 4,
    'green': 5,
    'blue': 6,
    'violet': 7,
    'grey': 8,
    'white': 9,
}

TOLERANCE_MAP = {
    'grey': '±0.05%',
    'violet': '±0.1%',
    'blue': '±0.25%',
    'green': '±0.5%',
    'brown': '±1%',
    'red': '±2%',
    'gold': '±5%',
    'silver': '±10%',
}


def value(colors: List[str]) -> float:
    v = 0
    for c in colors:
        v = v * 10 + COLOR_MAP[c]

    return v


def resistor_label(colors: List[str]) -> str:
    if len(colors) == 1:
        return f'{COLOR_MAP[colors[0]]} ohms'

    n = value(colors[:-2])

    zeros = COLOR_MAP[colors[-2]]
    n *= 10**zeros
    i = 0
    while n >= 1000:
        i += 1
        n /= 1000

    if int(n) == n:
        n = int(n)

    metrics = ['ohms', 'kiloohms', 'megaohms', 'gigaohms']

    tolerance = TOLERANCE_MAP[colors[-1]]
    return f'{n} {metrics[i]} {tolerance}'
