local function decode(bytes)
    local t = {}
    local n = 0
    local is_complete = false
    for _, b in ipairs(bytes) do
        n = n + (b & 0x7F)
        if b >> 7 == 0 then
            is_complete = true
            table.insert(t, n)
            n = 0
        else
            is_complete = false
            n = n << 7
        end
    end
    assert(is_complete, "incomplete byte sequence")
    return t
end

local function reverse(t)
    for i = 1, #t // 2 do
        local j = #t - i + 1
        local tmp = t[i]
        t[i] = t[j]
        t[j] = tmp
    end
end

local function encode(values)
    local t = {}
    reverse(values)
    for _, n in ipairs(values) do
        if n == 0 then
            table.insert(t, 0)
        else
            local h = 0
            while n > 0 do
                local d = n & 0x7F | h
                h = h | 0x80
                n = n >> 7
                table.insert(t, d)
            end
        end
    end

    reverse(t)
    return t
end

return { decode = decode, encode = encode }
