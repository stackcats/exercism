local function is_rect(grid, a, b, c, d)
    if a[1] ~= b[1] then
        return 0
    end

    if a[2] ~= c[2] then
        return 0
    end

    if c[1] ~= d[1] then
        return 0
    end

    if b[2] ~= d[2] then
        return 0
    end

    for k = a[2], b[2] do
        if not grid[a[1]]:sub(k, k):match("[-+]") then
            return 0
        end
        if not grid[c[1]]:sub(k, k):match("[-+]") then
            return 0
        end
    end

    for k = a[1], c[1] do
        if not grid[k]:sub(a[2], a[2]):match("[|+]") then
            return 0
        end
        if not grid[k]:sub(b[2], b[2]):match("[|+]") then
            return 0
        end
    end

    return 1
end

return {
    count = function(grid)
        local points = {}
        for i, row in ipairs(grid) do
            for j = 1, #row do
                if row:sub(j, j) == "+" then
                    table.insert(points, { i, j })
                end
            end
        end

        table.sort(points, function(a, b)
            if a[1] == b[1] then
                return a[2] < b[2]
            end
            return a[1] < b[1]
        end)

        local ct = 0

        for i = 1, #points - 3 do
            for j = i + 1, #points - 2 do
                for k = j + 1, #points - 1 do
                    for m = k + 1, #points do
                        ct = ct + is_rect(grid, points[i], points[j], points[k], points[m])
                    end
                end
            end
        end

        return ct
    end,
}

