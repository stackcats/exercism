local is_prime = function(n)
    if n < 2 then
        return false
    end

    if n == 2 then
        return true
    end

    for i = 2, math.ceil(n ^ 0.5) do
        if n % i == 0 then
            return false
        end
    end
    return true
end

return function(n)
    if n <= 0 then
        error("n should > 0")
    end

    local i = 0
    local m = 0
    while i < n do
        m = m + 1
        if is_prime(m) then
            i = i + 1
        end
    end
    return m
end

