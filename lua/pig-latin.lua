local function rule1(s)
    if s:match("^[aeiou]") or s:sub(1, 2) == "xr" or s:sub(1, 2) == "yt" then
        return s
    end
    return nil
end

local function rule2(s)
    local i, j = s:find("^[^aeiou]+")
    return s:sub(j + 1, -1) .. s:sub(i, j)
end

local function rule3(s)
    if s:match("^[^aeiou]*qu") then
        local i, j = s:find("^[^aeiou]*qu")
        return s:sub(j + 1, -1) .. s:sub(i, j)
    end
    return nil
end

local function rule4(s)
    if s:match("^[^aeiou]+y") then
        local i, j = s:find("^[^aeiou]+y")
        return s:sub(j, -1) .. s:sub(i, j - 1)
    end
    return nil
end

local function translate(s)
    local t = rule1(s) or rule3(s) or rule4(s) or rule2(s)
    return t .. "ay"
end

return function(phrase)
    local s = ""
    for p in phrase:gmatch("%S+") do
        if #s > 0 then
            s = s .. " "
        end
        s = s .. translate(p)
    end
    return s
end
