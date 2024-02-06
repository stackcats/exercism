local function transform(board)
    local dir = { { -1, -1 }, { -1, 0 }, { -1, 1 }, { 0, 1 }, { 1, 1 }, { 1, 0 }, { 1, -1 }, { 0, -1 } }
    local mat = {}
    table.insert(mat, board[1])
    for i = 2, #board - 1 do
        assert(#board[i] == #board[i - 1])
        local row = { "|" }
        for j = 2, #board[i] - 1 do
            assert(board[i]:sub(j, j):match("[* ]"))
            if board[i]:sub(j, j) == "*" then
                table.insert(row, "*")
            else
                local ct = 0
                for _, d in ipairs(dir) do
                    local ni = i + d[1]
                    local nj = j + d[2]
                    if ni > 1 and ni < #board and nj > 1 and nj < #board[i] and board[ni]:sub(nj, nj) == "*" then
                        ct = ct + 1
                    end
                end
                table.insert(row, ct == 0 and " " or ct)
            end
        end
        table.insert(row, "|")
        table.insert(mat, table.concat(row))
    end
    table.insert(mat, board[#board])
    return mat
end

return { transform = transform }
