local function keep(xs, pred)
    local t = {}
    for _, x in ipairs(xs) do
        if pred(x) then
            table.insert(t, x)
        end
    end
    return t
end

local function discard(xs, pred)
    p = function(x)
        return not pred(x)
    end
    return keep(xs, p)
end

return { keep = keep, discard = discard }
