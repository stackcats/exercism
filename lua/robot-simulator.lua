return function(config)
    local dir = {
        north = { 0, 1 },
        south = { 0, -1 },
        west = { -1, 0 },
        east = { 1, 0 },
    }
    local facing = { "north", "east", "south", "west" }
    local facing_index = {
        north = 1,
        east = 2,
        south = 3,
        west = 4,
    }
    return {
        x = config.x,
        y = config.y,
        ndx = facing_index[config.heading],
        heading = config.heading,
        move = function(self, cmd)
            if cmd:match("[^ALR]") then
                return error("invalid")
            end
            for c in cmd:gmatch(".") do
                if c == "A" then
                    self.x = self.x + dir[self.heading][1]
                    self.y = self.y + dir[self.heading][2]
                elseif c == "L" then
                    local i = facing_index[self.heading]
                    i = (i - 1 - 1 + 4) % 4 + 1
                    self.heading = facing[i]
                elseif c == "R" then
                    local i = facing_index[self.heading]
                    i = (i - 1 + 1) % 4 + 1
                    self.heading = facing[i]
                end
            end
        end,
    }
end
