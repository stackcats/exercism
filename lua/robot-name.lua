local names = {}

local function rand()
    local a = string.char(math.random(97, 122))
    local b = string.char(math.random(97, 122))
    local c = math.random(100, 999)
    return string.format("%s%s%d", a, b, c)
end

local function gen()
    local name = rand()
    while names[name] ~= nil do
        name = rand()
    end
    table.insert(names, name)
    return name
end

local Robot = {
    new = function(_)
        return {
            name = gen(),
            reset = function(self)
                self.name = gen()
            end,
        }
    end,
}

return Robot
