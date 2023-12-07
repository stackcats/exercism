return function(array, target)
    local i = 1
    local j = #array
    while i <= j do
        local m = (i + j) // 2
        if array[m] == target then
            return m
        elseif array[m] < target then
            i = m + 1
        else
            j = m - 1
        end
    end
    return -1
end
