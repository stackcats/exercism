local SpaceAge = {}

local function round(n)
    return math.floor(n * 100 + 0.5) / 100
end

function SpaceAge:new(seconds)
    local sec = seconds / 31557600
    return {
        seconds = seconds,
        on_earth = function()
            return round(sec)
        end,
        on_mercury = function()
            return round(sec / 0.2408467)
        end,
        on_venus = function()
            return round(sec / 0.61519726)
        end,
        on_mars = function()
            return round(sec / 1.8808158)
        end,
        on_jupiter = function()
            return round(sec / 11.862615)
        end,
        on_saturn = function()
            return round(sec / 29.447498)
        end,
        on_uranus = function()
            return round(sec / 84.016846)
        end,
        on_neptune = function()
            return round(sec / 164.79132)
        end,
    }
end

return SpaceAge

