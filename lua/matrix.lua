local transpose = function(mat)
    local t = {}
    for i = 1, #mat[1] do
        t[i] = {}
        for j = 1, #mat do
            t[i][j] = mat[j][i]
        end
    end
    return t
end

return function(s)
    local mat = {}
    for r in s:gmatch("[^\n]+") do
        local row = {}
        for c in r:gmatch("[%d]+") do
            table.insert(row, tonumber(c))
        end
        table.insert(mat, row)
    end

    local trans = transpose(mat)

    return {
        row = function(i)
            return mat[i]
        end,

        column = function(i)
            return trans[i]
        end,
    }
end
