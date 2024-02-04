local numbers = {
    [" _ | ||_|   "] = "0",
    ["     |  |   "] = "1",
    [" _  _||_    "] = "2",
    [" _  _| _|   "] = "3",
    ["   |_|  |   "] = "4",
    [" _ |_  _|   "] = "5",
    [" _ |_ |_|   "] = "6",
    [" _   |  |   "] = "7",
    [" _ |_||_|   "] = "8",
    [" _ |_| _|   "] = "9",
}
return {
    convert = function(s)
        local rows = {}
        local pre_len
        for row in s:gmatch("[^\n]+") do
            if pre_len then
                assert(#row % 3 == 0 and #row == pre_len)
            end
            pre_len = #row
            table.insert(rows, row)
        end

        assert(#rows % 4 == 0)

        local t = ""
        for i = 1, #rows, 4 do
            if t ~= "" then
                t = t .. ","
            end
            for j = 1, #rows[i], 3 do
                local n = rows[i]:sub(j, j + 2)
                    .. rows[i + 1]:sub(j, j + 2)
                    .. rows[i + 2]:sub(j, j + 2)
                    .. rows[i + 3]:sub(j, j + 2)
                t = t .. (numbers[n] or "?")
            end
        end

        return t
    end,
}

