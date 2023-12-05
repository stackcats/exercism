local PopCount = {}

function PopCount.egg_count(number)
    local ct = 0
    while number > 0 do
        ct = ct + number % 2
        number = number // 2
    end

    return ct
end

return PopCount
