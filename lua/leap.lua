return function(y)
    return y % 4 == 0 and y % 100 ~= 0 or y % 400 == 0
end
