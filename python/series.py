def slices(series, length):
    if not series:
        raise ValueError('series cannot be empty')
    if length < 0:
        raise ValueError('slice length cannot be negative')
    if length == 0:
        raise ValueError('slice length cannot be zero')
    if length > len(series):
        raise ValueError('slice length cannot be greater than series length')
    lst = []
    for i in range(len(series) - length + 1):
        lst.append(series[i:i + length])
    return lst
