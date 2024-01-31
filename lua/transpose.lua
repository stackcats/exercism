local function rtrim(s)
    return string.gsub(s, "(.-)%s*$", "%1")
end

local function lpad(s, width)
    if width < 1 then
        return s
    end
    local fmt = string.format("%%-%ds", width)
    return string.format(fmt, s)
end

return function(s)
    local mat = {}
    local max_col = 0
    for r in s:gmatch("[^\n]*") do
        max_col = math.max(max_col, #r)
        table.insert(mat, r)
    end

    for i = 1, #mat do
        mat[i] = lpad(mat[i], max_col)
    end

    local trans = {}

    for j = 1, max_col do
        local r = ""
        for _, row in ipairs(mat) do
            r = r .. row:sub(j, j)
        end
        table.insert(trans, r)
    end

    local pad = 0
    for i = #trans, 1, -1 do
        trans[i] = lpad(rtrim(trans[i]), pad)
        pad = math.max(pad, #trans[i])
    end

    return table.concat(trans, "\n")
end

