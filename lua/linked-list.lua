local Node = {}
Node.__index = Node

function Node:new(v, prev, next)
    local t = {
        v = v,
        prev = prev,
        next = next,
    }

    return setmetatable(t, Node)
end

local List = {}
List.__index = List

function List:push(v)
    local node = Node:new(v)
    if self.head == nil then
        self.head = node
        self.tail = node
    else
        self.tail.next = node
        node.prev = self.tail
        self.tail = node
    end
    self.ct = self.ct + 1
end

function List:pop()
    local node = self.tail
    self.tail = node.prev
    if self.tail == nil then
        self.head = nil
    end
    self.ct = self.ct - 1
    return node.v
end

function List:shift()
    local node = self.head
    self.head = node.next
    if self.head == nil then
        self.tail = nil
    end
    self.ct = self.ct - 1
    return node.v
end

function List:unshift(v)
    local node = Node:new(v)
    if self.head == nil then
        self.head = node
        self.tail = node
    else
        self.head.prev = node
        node.next = self.head
        self.head = node
    end
    self.ct = self.ct + 1
end

function List:count()
    return self.ct
end

function List:delete(v)
    local curr = self.head
    local prev = nil
    while curr ~= nil do
        if curr.v == v then
            self.ct = self.ct - 1
            if prev == nil then
                self.head = curr.next
            else
                prev.next = curr.next
                if curr.next ~= nil then
                    curr.next.prev = prev
                else
                    self.tail = prev
                end
            end
        end
        prev = curr
        curr = curr.next
    end
end

return function()
    local t = {
        head = nil,
        tail = nil,
        ct = 0,
    }
    return setmetatable(t, List)
end

