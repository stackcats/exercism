return function(s)
    return {
        to_decimal = function()
            if s:match("[^0-7]") then
                return 0
            end

            local n = 0
            for c in s:gmatch(".") do
                n = n * 8 + (c - "0")
            end

            return n
        end,
    }
end
