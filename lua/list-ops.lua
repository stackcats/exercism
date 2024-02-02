local function reduce(xs, value, f)
    for _, x in ipairs(xs) do
        value = f(x, value)
    end
    return value
end

local function map(xs, f)
    local ys = {}
    for i = 1, #xs do
        ys[i] = f(xs[i])
    end
    return ys
end

local function filter(xs, pred)
    local ys = {}
    for i = 1, #xs do
        if pred(xs[i]) then
            table.insert(ys, xs[i])
        end
    end
    return ys
end

return { map = map, reduce = reduce, filter = filter }
