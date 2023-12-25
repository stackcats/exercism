return function(input)
    local t = {}
    local curr = 2
    while input >= curr do
        if input % curr == 0 then
            table.insert(t, curr)
            input = input / curr
        else
            curr = curr + 1
        end
    end
    return t
end
