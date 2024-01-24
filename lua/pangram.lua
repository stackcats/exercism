return function(s)
    local t = {}
    for c in s:lower():gmatch("[a-z]") do
        t[c] = 1
    end
    local ct = 0
    for _, _ in pairs(t) do
        ct = ct + 1
    end
    return ct == 26
end

