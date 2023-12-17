local function to_decimal(input)
    if input:match("[^01]") then
        return 0
    end

    local n = 0
    local m = 1

    for c in input:reverse():gmatch(".") do
        if c == "1" then
            n = n + m
        end
        m = m * 2
    end

    return n
end

return {
    to_decimal = to_decimal,
}
