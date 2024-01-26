return function(n)
    assert(n > 0, "Only positive numbers are allowed")
    local ct = 0
    while n > 1 do
        if n % 2 == 0 then
            n = n // 2
        else
            n = n * 3 + 1
        end
        ct = ct + 1
    end
    return ct
end
