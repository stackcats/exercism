from collections import Counter

DISCOUNT = {1: 0, 2: 0.05, 3: 0.1, 4: 0.2, 5: 0.25}


def total(basket):
    ct = Counter(basket)
    group = []
    while distinct_ct := len(ct):
        group.append(distinct_ct)
        ct.subtract(ct.keys())
        ct = +ct
    while 3 in group and 5 in group:
        group.remove(3)
        group.remove(5)
        group += [4, 4]
    return sum(800 * x * (1 - DISCOUNT[x]) for x in group)
