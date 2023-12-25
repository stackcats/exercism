return function(sum)
    local t = {}
    for i = 1, sum do
        for j = i + 1, sum do
            local k = sum - j - i
            if i * i + j * j == k * k then
                table.insert(t, { i, j, k })
            end
        end
    end
    return t
end
