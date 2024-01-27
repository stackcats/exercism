local t = {
    black = 0,
    brown = 1,
    red = 2,
    orange = 3,
    yellow = 4,
    green = 5,
    blue = 6,
    violet = 7,
    grey = 8,
    white = 9,
}

return {
    decode = function(c1, c2, c3)
        local n = (t[c1] * 10 + t[c2]) * math.floor(10 ^ t[c3])
        local prefix = { "", "kilo", "mega", "giga" }
        local i = 1
        while n >= 1000 do
            n = n // 1000
            i = i + 1
        end
        return n, prefix[i] .. "ohms"
    end,
}
