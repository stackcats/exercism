local function list(score)
    local items = {
        "eggs",
        "peanuts",
        "shellfish",
        "strawberries",
        "tomatoes",
        "chocolate",
        "pollen",
        "cats",
    }
    local t = {}
    for i, item in ipairs(items) do
        local n = 2 ^ (i - 1)
        if score & n == n then
            table.insert(t, item)
        end
    end
    return t
end

local function allergic_to(score, which)
    local lst = list(score)
    for _, item in ipairs(lst) do
        if item == which then
            return true
        end
    end
    return false
end

return { list = list, allergic_to = allergic_to }
