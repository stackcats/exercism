def saddle_points(matrix):
    if matrix == []:
        return []

    rows = len(matrix)
    cols = len(matrix[0])

    def is_max_in_row(i, j):
        for k in range(cols):
            if k == j:
                continue
            if matrix[i][k] > matrix[i][j]:
                return False
        return True

    def is_min_in_col(i, j):
        for k in range(rows):
            if k == i:
                continue
            if matrix[k][j] < matrix[i][j]:
                return False
        return True

    res = []
    for i in range(rows):
        if len(matrix[i]) != cols:
            raise ValueError('irregular matrix')
        for j in range(cols):
            if is_max_in_row(i, j) and is_min_in_col(i, j):
                res.append({'row': i + 1, 'column': j + 1})
    return res
