return function(n)
    local t = { { 1 } }
    for _ = 2, n do
        local row = { 1 }
        local last = t[#t]
        for i = 1, #last - 1 do
            table.insert(row, last[i] + last[i + 1])
        end
        table.insert(row, 1)
        table.insert(t, row)
    end

    return {
        rows = t,
        last_row = t[#t],
    }
end
