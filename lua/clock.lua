local Clock = {}
Clock.__index = Clock

function Clock.at(hours, minutes)
    minutes = minutes or 0
    local t = {
        hours = (hours + minutes // 60) % 24,
        minutes = minutes % 60,
    }
    return setmetatable(t, Clock)
end

function Clock.__tostring(t)
    return string.format("%02d:%02d", t.hours, t.minutes)
end

function Clock:plus(minutes)
    return Clock.at(self.hours, self.minutes + minutes)
end

function Clock:minus(minutes)
    return Clock.at(self.hours, self.minutes - minutes)
end

function Clock:equals(other)
    return self.hours == other.hours and self.minutes == other.minutes
end

return Clock
