from itertools import permutations


def combinations(target: int, size: int,
                 exclude: list[int]) -> list[list[int]]:
    perms = set([tuple(sorted(p)) for p in permutations(range(1, 10), size)])
    res = []
    exclude_set = set(exclude)
    for p in perms:
        if sum(p) == target and exclude_set.isdisjoint(p):
            res.append(sorted(list(p)))

    res.sort()
    return res
