DIGITS_MAP = {
    ' _ | ||_|   ': '0',
    '     |  |   ': '1',
    ' _  _||_    ': '2',
    ' _  _| _|   ': '3',
    '   |_|  |   ': '4',
    ' _ |_  _|   ': '5',
    ' _ |_ |_|   ': '6',
    ' _   |  |   ': '7',
    ' _ |_||_|   ': '8',
    ' _ |_| _|   ': '9',
}


def convert(input_grid):
    if len(input_grid) % 4 != 0:
        raise ValueError('Number of input lines is not a multiple of four')

    if not all(len(row) % 3 == 0 for row in input_grid):
        raise ValueError('Number of input columns is not a multiple of three')

    res = []
    for i in range(0, len(input_grid), 4):
        n = ''
        for j in range(0, len(input_grid[0]), 3):
            s = ''
            for k in range(4):
                s += input_grid[i + k][j:j + 3]
            if s in DIGITS_MAP:
                n += DIGITS_MAP[s]
            else:
                n += '?'
        res.append(n)
    return ','.join(res)
