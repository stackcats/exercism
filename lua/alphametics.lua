local function map(f, a, ...)
    if a then
        return f(a), map(f, ...)
    end
end

local function incr(k)
    return function(a)
        return k > a and a or a + 1
    end
end

local function comb(m, n)
    if m * n == 0 then
        return { {} }
    end
    local ret, old = {}, comb(m - 1, n - 1)
    for i = 0, n do
        for _, v in ipairs(old) do
            ret[#ret + 1] = { i, map(incr(i), table.unpack(v)) }
        end
    end
    return ret
end

local function eval(s)
    return load("return " .. s)()
end

local function has_leading_zero(s)
    return s:match("^0%D") or s:match("%D0%d")
end

local function solve(puzzle)
    local letters = {}
    for c in puzzle:gmatch("%a") do
        letters[c] = 1
    end
    local vars = {}
    for c in pairs(letters) do
        table.insert(vars, c)
    end

    local combs = comb(#vars, 9)
    for _, c in ipairs(combs) do
        local t = {}
        for i = 1, #c do
            t[vars[i]] = c[i]
        end
        local s = puzzle:gsub("%a", t)
        if not has_leading_zero(s) and eval(s) then
            return t
        end
    end
end

return { solve = solve }

