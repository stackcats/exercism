local BinarySearchTree = {}
BinarySearchTree.__index = BinarySearchTree

function BinarySearchTree:new(value)
    local t = {
        value = value,
        left = nil,
        right = nil,
    }
    setmetatable(t, BinarySearchTree)
    return t
end

function BinarySearchTree:insert(value)
    if self == nil then
        return BinarySearchTree:new(value)
    end
    if self.value >= value then
        self.left = self.insert(self.left, value)
    else
        self.right = self.insert(self.right, value)
    end

    return self
end

function BinarySearchTree:from_list(lst)
    assert(#lst > 0)
    local t = nil
    for _, v in ipairs(lst) do
        if t == nil then
            t = BinarySearchTree:new(v)
        else
            t:insert(v)
        end
    end
    return t
end

function BinarySearchTree:values()
    return coroutine.wrap(function()
        if self == nil then
            return
        end

        if self.left then
            for v in self.left:values() do
                coroutine.yield(v)
            end
        end

        coroutine.yield(self.value)

        if self.right then
            for v in self.right:values() do
                coroutine.yield(v)
            end
        end
    end)
end

return BinarySearchTree

