return function(which)
    if which == "A" then
        return "A\n"
    end

    local t = ""

    local side_width = string.byte(which) - string.byte("A")
    local width = side_width * 2 + 1

    for b = string.byte("A"), string.byte(which) do
        local center_width = width - 2 * side_width - 2
        local s = string.rep(" ", side_width) .. string.char(b)
        if center_width > 0 then
            s = s .. string.rep(" ", center_width) .. string.char(b)
        end
        s = s .. string.rep(" ", side_width)
        t = t .. s .. "\n"
        side_width = side_width - 1
    end

    side_width = side_width + 2

    for b = string.byte(which) - 1, string.byte("A"), -1 do
        local center_width = width - 2 * side_width - 2
        local s = string.rep(" ", side_width) .. string.char(b)
        if center_width > 0 then
            s = s .. string.rep(" ", center_width) .. string.char(b)
        end
        s = s .. string.rep(" ", side_width)
        t = t .. s .. "\n"
        side_width = side_width + 1
    end

    return t
end

