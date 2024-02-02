local School = {}
School.__index = School

function School:new()
    local t = {
        grades = {},
    }
    return setmetatable(t, School)
end

function School:add(name, grade)
    if self.grades[grade] == nil then
        self.grades[grade] = {}
    end

    table.insert(self.grades[grade], name)
    table.sort(self.grades[grade])
end

function School:roster()
    return self.grades
end

function School:grade(n)
    return self.grades[n] or {}
end

return School

