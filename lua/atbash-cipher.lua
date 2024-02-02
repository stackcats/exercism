return {
    encode = function(plaintext)
        local t = ""
        local i = 0
        for c in plaintext:lower():gmatch("[a-z0-9]") do
            if i > 0 and i % 5 == 0 then
                t = t .. " "
            end
            if c:match("[0-9]") then
                t = t .. c
            else
                t = t .. string.char(122 - string.byte(c) + 97)
            end
            i = i + 1
        end
        return t
    end,
}

