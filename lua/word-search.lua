local function search(puzzle, i, j, word)
    local dirs = { { 1, 0 }, { 1, -1 }, { 0, -1 }, { -1, -1 }, { -1, 0 }, { -1, 1 }, { 0, 1 }, { 1, 1 } }
    for k = 1, #word do
        local new_dirs = {}
        for d = 1, #dirs do
            local ti = i + (k - 1) * dirs[d][1]
            local tj = j + (k - 1) * dirs[d][2]
            if puzzle[ti] and puzzle[ti]:sub(tj, tj) == word:sub(k, k) then
                table.insert(new_dirs, dirs[d])
            end
        end
        dirs = new_dirs
    end
    if #dirs == 0 then
        return nil
    end
    return { j, i }, { j + (#word - 1) * dirs[1][2], i + (#word - 1) * dirs[1][1] }
end

return function(puzzle)
    return {
        find = function(word)
            for i, row in ipairs(puzzle) do
                for j = 1, #row do
                    local first, last = search(puzzle, i, j, word)
                    if first then
                        return first, last
                    end
                end
            end
        end,
    }
end
