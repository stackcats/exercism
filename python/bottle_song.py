MAP = [
    'no', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight',
    'Nine', 'Ten'
]


def plural(n):
    if n == 1:
        return ''
    return 's'


def step(n):
    return [
        f"{MAP[n]} green bottle{plural(n)} hanging on the wall,",
        f"{MAP[n]} green bottle{plural(n)} hanging on the wall,",
        "And if one green bottle should accidentally fall,",
        f"There'll be {MAP[n-1].lower()} green bottle{plural(n-1)} hanging on the wall."
    ]


def recite(start, take=1):
    res = []
    for i in range(take):
        lst = step(start)
        res.extend(lst)
        res.append("")
        start -= 1

    return res[:-1]
