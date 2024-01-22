return function(n)
    local arr = { "wink", "double blink", "close your eyes", "jump" }
    local t = {}
    for i, s in ipairs(arr) do
        local m = 2 ^ (i - 1)
        if n & m == m then
            table.insert(t, s)
        end
    end
    if n & 16 == 16 then
        local t2 = {}
        for _, s in ipairs(t) do
            table.insert(t2, 1, s)
        end
        return t2
    end
    return t
end
