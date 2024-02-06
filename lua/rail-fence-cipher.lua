local function encode(plaintext, rail_count)
    local t = {}
    local r = 1
    local dr = 1
    for c in plaintext:gmatch(".") do
        t[r] = (t[r] or "") .. c
        if r + dr > rail_count or r + dr < 1 then
            dr = dr * -1
        end
        r = r + dr
    end
    return table.concat(t)
end

local function decode(ciphertext, rail_count)
    local s = ciphertext
    while encode(s, rail_count) ~= ciphertext do
        s = encode(s, rail_count)
    end
    return s
end

return { encode = encode, decode = decode }
