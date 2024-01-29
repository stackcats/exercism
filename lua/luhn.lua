return {
    valid = function(s)
        if s:match("[^0-9 ]") then
            return false
        end

        if #s < 2 then
            return false
        end

        local flag = #s % 2 == 0
        local sum = 0
        for c in s:gmatch("%S") do
            local n = c - "0"
            if flag then
                n = n * 2
                if n > 9 then
                    n = n - 9
                end
            end
            sum = sum + n
            flag = not flag
        end

        return sum % 10 == 0
    end,
}

