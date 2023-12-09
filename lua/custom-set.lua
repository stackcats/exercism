local set = {}
set.__index = set

local new = function(...)
    local t = { mp = {} }
    for _, v in ipairs({ ... }) do
        t.mp[v] = true
    end
    return setmetatable(t, set)
end

function set:is_empty()
    return #self.mp == 0
end

function set:contains(v)
    return self.mp[v] == true
end

function set:is_subset(other)
    for v, _ in pairs(self.mp) do
        if not other:contains(v) then
            return false
        end
    end
    return true
end

function set:is_disjoint(other)
    for v, _ in pairs(self.mp) do
        if other:contains(v) then
            return false
        end
    end
    return true
end

function set:equals(other)
    return self:is_subset(other) and other:is_subset(self)
end

function set:add(v)
    self.mp[v] = true
end

function set:intersection(other)
    local ret = new()
    for v, _ in pairs(self.mp) do
        if other:contains(v) then
            ret:add(v)
        end
    end
    return ret
end

function set:union(other)
    local ret = new()
    for v, _ in pairs(self.mp) do
        ret:add(v)
    end
    for v, _ in pairs(other.mp) do
        ret:add(v)
    end
    return ret
end

function set:difference(other)
    local ret = new()
    for v, _ in pairs(self.mp) do
        if not other:contains(v) then
            ret:add(v)
        end
    end
    return ret
end

return new
