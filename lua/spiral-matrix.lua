return function(size)
    if size == 0 then
        return {}
    end

    local mat = {}

    for i = 1, size do
        mat[i] = {}
        for j = 1, size do
            mat[i][j] = 0
        end
    end

    local dir = { { 0, 1 }, { 1, 0 }, { 0, -1 }, { -1, 0 } }
    local d = 1
    local x = 1
    local y = 1

    for i = 1, size * size do
        mat[x][y] = i
        local dx, dy = table.unpack(dir[d])
        local nx = x + dx
        local ny = y + dy
        if nx > size or nx < 1 or ny > size or ny < 1 or mat[nx][ny] > 0 then
            d = d % 4 + 1
            dx, dy = table.unpack(dir[d])
            nx = x + dx
            ny = y + dy
        end
        x = nx
        y = ny
    end

    return mat
end
