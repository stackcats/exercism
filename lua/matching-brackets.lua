return {
    valid = function(s)
        local st = {}
        for c in s:gmatch(".") do
            if c == "[" or c == "{" or c == "(" then
                table.insert(st, c)
            elseif c == ")" then
                if st[#st] ~= "(" then
                    return false
                end
                table.remove(st)
            elseif c == "}" then
                if st[#st] ~= "{" then
                    return false
                end
                table.remove(st)
            elseif c == "]" then
                if st[#st] ~= "[" then
                    return false
                end
                table.remove(st)
            end
        end
        return #st == 0
    end,
}
