local Anagram = {}
Anagram.__index = Anagram

local function sort(s)
    local t = {}
    for c in s:lower():gmatch(".") do
        table.insert(t, c)
    end
    table.sort(t)

    local s = ""
    for _, c in ipairs(t) do
        s = s .. c
    end
    return s
end

function Anagram:new(s)
    local t = {
        word = s,
        sorted = sort(s),
    }
    return setmetatable(t, Anagram)
end

function Anagram:match(arr)
    local t = {}
    for _, each in ipairs(arr) do
        if each ~= self.word then
            local sorted = sort(each)
            if sorted == self.sorted then
                table.insert(t, each)
            end
        end
    end
    return t
end

return Anagram
