from itertools import permutations


def is_dominoe(lst):
    for i in range(len(lst) - 1):
        if lst[i][1] == lst[i + 1][0]:
            continue
        if lst[i][1] != lst[i + 1][1]:
            return False
        lst[i + 1] = lst[i + 1][::-1]

    return lst[0][0] == lst[-1][1]


def can_chain(dominoes):
    if dominoes == []:
        return []

    perms = permutations(dominoes)
    for perm in perms:
        lst = list(perm)
        if is_dominoe(lst):
            return lst

    return None
