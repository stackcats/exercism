local function flatten(input)
    local t = {}
    for _, x in ipairs(input) do
        if type(x) == "table" then
            local r = flatten(x)
            for _, y in ipairs(r) do
                table.insert(t, y)
            end
        else
            table.insert(t, x)
        end
    end
    return t
end

return flatten
