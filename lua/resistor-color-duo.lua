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
    value = function(colors)
        return t[colors[1]] * 10 + t[colors[2]]
    end,
}
