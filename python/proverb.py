def proverb(*lst, qualifier=None):
    if lst == ():
        return []

    res = []

    for i in range(len(lst) - 1):
        sublst = lst[i:i + 2]
        res.append(f'For want of a {sublst[0]} the {sublst[1]} was lost.')

    if qualifier is None:
        res.append(f'And all for the want of a {lst[0]}.')
    else:
        res.append(f'And all for the want of a {qualifier} {lst[0]}.')
    return res
