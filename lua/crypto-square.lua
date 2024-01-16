return {
    ciphertext = function(plaintext)
        plaintext = plaintext:gsub("[^%w]", ""):lower()
        if plaintext == "" then
            return ""
        end
        local root = (#plaintext) ^ 0.5
        local r = math.floor(root)
        local c = math.ceil(root)
        local fmt = string.format("%%-%ds", r * c)
        plaintext = string.format(fmt, plaintext)
        local t = {}
        local k = 0
        for i = 1, r do
            t[i] = {}
            for j = 1, c do
                t[i][j] = plaintext:sub(k, k)
                k = k + 1
            end
        end
        local o = {}
        for j = 1, c do
            table.insert(o, "")
            for i = 1, r do
                o[#o] = o[#o] .. t[i][j]
            end
        end
        return table.concat(o, " ")
    end,
}

