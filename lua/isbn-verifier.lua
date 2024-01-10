return {
    valid = function(isbn)
        isbn = isbn:gsub("[^%dX]", "")
        if not isbn:match("^%d%d%d%d%d%d%d%d%d[%dX]$") then
            return false
        end

        local n = 10
        local sum = 0
        for c in isbn:gmatch(".") do
            sum = sum + (tonumber(c) or 10) * n
            n = n - 1
        end
        return sum % 11 == 0
    end,
}

