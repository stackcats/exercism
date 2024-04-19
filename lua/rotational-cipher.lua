return {
    rotate = function(input, key)
        return input:gsub(".", function(c)
            if not c:match("%a") then
                return c
            end
            local start = c:match("%l") and "a" or "A"
            return string.char(start:byte() + (c:byte() - start:byte() + key) % 26)
        end)
    end,
}
