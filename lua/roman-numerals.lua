return {
    to_roman = function(n)
        local arr = { { "I", "V", "X" }, { "X", "L", "C" }, { "C", "D", "M" }, { "M", "M", "M" } }
        local s = ""
        local i = 1
        while n > 0 do
            local l, v, x = table.unpack(arr[i])
            local d = n % 10
            if d == 0 then
            elseif d == 1 or d == 2 or d == 3 then
                s = l:rep(d) .. s
            elseif d == 4 then
                s = l .. v .. s
            elseif d == 5 then
                s = v .. s
            elseif d == 6 or d == 7 or d == 8 then
                s = v .. l:rep(d - 5) .. s
            else
                s = l .. x .. s
            end
            n = n // 10
            i = i + 1
        end

        return s
    end,
}
