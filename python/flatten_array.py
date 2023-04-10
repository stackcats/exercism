def flatten(iterable):
    res = []
    for each in iterable:
        if each is None:
            continue
        if isinstance(each, list):
            res.extend(flatten(each))
        else:
            res.append(each)
    return res
