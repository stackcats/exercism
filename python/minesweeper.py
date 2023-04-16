def calc_mines(minefield, i, j):
    mines = 0;
    rows = len(minefield)
    cols = len(minefield[0])
    for di in [-1, 0, 1]:
        for dj in [-1, 0, 1]:
            if i+di < 0 or i+di >= rows or j+dj < 0 or j+dj >= cols:
                continue
            if minefield[i+di][j+dj] == '*':
                mines += 1
    return mines


def annotate(minefield):
    if minefield == []:
        return []
        
    rows = len(minefield)
    cols = len(minefield[0])

    res = [[None] * cols for _ in range(rows)]
    
    for i in range(rows):
        if len(minefield[i]) != cols:
                raise ValueError('The board is invalid with current input.')
        for j in range(cols):
            if minefield[i][j] == '*':
                res[i][j] = '*'
            elif minefield[i][j] == ' ':
                mines = calc_mines(minefield, i, j)
                res[i][j] = mines == 0 and ' ' or str(mines)
            else:
                raise ValueError('The board is invalid with current input.')

    return [''.join(row) for row in res]
