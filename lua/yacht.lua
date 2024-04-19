local yacht = {}

function indexOf(t, val)
    for i, v in ipairs(t) do
        if v == val then
            return i
        end
    end
    return -1
end

function findCount(t, val)
    for _, v in pairs(t) do
        if v == val then
            return true
        end
    end
    return false
end

yacht.score = function(dice, category)
    table.sort(dice)

    local t = {}
    local sum = 0
    for _, v in ipairs(dice) do
        t[v] = (t[v] or 0) + 1
        sum = sum + v
    end

    local nums = { "ones", "twos", "threes", "fours", "fives", "sixes" }

    local index = indexOf(nums, category)
    if index ~= -1 then
        return (t[index] or 0) * index
    end

    if category == "yacht" then
        if findCount(t, 5) then
            return 50
        end
    end

    if category == "full house" then
        if findCount(t, 3) and findCount(t, 2) then
            return sum
        end
    end

    if category == "four of a kind" then
        for k, v in pairs(t) do
            if v >= 4 then
                return k * 4
            end
        end
    end

    if category == "little straight" then
        if table.concat(dice) == "12345" then
            return 30
        end
    end

    if category == "big straight" then
        if table.concat(dice) == "23456" then
            return 30
        end
    end

    if category == "choice" then
        return sum
    end

    return 0
end

return yacht
