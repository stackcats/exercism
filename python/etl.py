def transform(legacy_data):
    res = {}
    for (k, v) in legacy_data.items():
        for c in v:
            res[c.lower()] = k
    return res
