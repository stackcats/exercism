from itertools import permutations
import re


def solve(puzzle):
    r = re.compile(r'(^0\d+|\s0)')
    lst = list(set(c for c in puzzle if c.isalpha()))

    for comb in permutations(range(10), len(lst)):
        mp = dict(zip(lst, comb))

        s = puzzle
        for (c, n) in mp.items():
            s = s.replace(c, str(n))

        if r.search(s):
            continue

        if eval(s):
            return mp

    return None

