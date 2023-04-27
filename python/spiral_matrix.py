def spiral_matrix(size):
    mat = [[0] * size for _ in range(size)]
    n = 1
    x, y = 0, 0
    dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)]
    d = 0
    dx, dy = dirs[d]
    while n <= size * size:
        mat[x][y] = n
        n += 1
        nx = x + dx
        ny = y + dy
        if nx < 0 or ny < 0 or nx >= size or ny >= size or mat[nx][ny] != 0:
            d = (d + 1) % 4
        dx, dy = dirs[d]
        x += dx
        y += dy
    return mat
