local function helper(t1, i, t2, j)
    if i > #t1 then
        return true
    end

    if j > #t2 then
        return false
    end

    if t1[i] ~= t2[j] then
        return helper(t1, i, t2, j + 1)
    end

    return helper(t1, i + 1, t2, j + 1)
end

return function(sublist, list)
    return helper(sublist, 1, list, 1)
end
