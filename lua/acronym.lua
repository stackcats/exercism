return function(s)
    local t = ""
    for w in s:gmatch("[a-zA-Z]+") do
        t = t .. w:sub(1, 1):upper()
        if w:upper() == w then
            goto continue
        end
        for u in w:sub(2, -1):gmatch("[A-Z]") do
            t = t .. u
        end

        ::continue::
    end
    return t
end
