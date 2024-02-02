local CircularBuffer = {}
CircularBuffer.__index = CircularBuffer

function CircularBuffer:new(cap)
    local t = {
        front = 1,
        rear = 1,
        len = 0,
        cap = cap,
        buf = {},
    }
    return setmetatable(t, CircularBuffer)
end

local function bump(n, len)
    return n % len + 1
end

function CircularBuffer:read()
    assert(self.len > 0 and self.len <= self.cap, "buffer is empty")
    local r = self.buf[self.front]
    self.front = bump(self.front, self.cap)
    self.len = self.len - 1
    return r
end

function CircularBuffer:write(n)
    if n == nil then
        return
    end
    assert(self.len < self.cap, "buffer is full")
    self.buf[self.rear] = n
    self.rear = bump(self.rear, self.cap)
    self.len = self.len + 1
end

function CircularBuffer:clear(n)
    self.buf = {}
    self.front = 1
    self.rear = 1
    self.len = 0
end

function CircularBuffer:forceWrite(n)
    if self.len < self.cap then
        return self:write(n)
    end
    self.buf[self.front] = n
    self.front = bump(self.front, self.cap)
end

return CircularBuffer

