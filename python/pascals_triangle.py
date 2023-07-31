def rows(row_count):
    if row_count < 0:
        raise ValueError('number of rows is negative')

    if row_count == 0:
        return []

    if row_count == 1:
        return [[1]]

    res = rows(row_count - 1)

    last = res[-1]
    next = [1]
    for i in range(1, len(last)):
        next.append(last[i] + last[i - 1])
    next.append(1)
    res.append(next)

    return res
