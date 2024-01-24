local PhoneNumber = {}
PhoneNumber.__index = PhoneNumber

function PhoneNumber:new(number)
    number = number:gsub("[^%d]", "")
    local default = "0000000000"
    if #number == 11 and number:sub(1, 1) == "1" then
        number = number:sub(2)
    end

    if #number ~= 10 then
        number = default
    end

    local t = {
        number = number,
    }
    return setmetatable(t, PhoneNumber)
end

function PhoneNumber:areaCode()
    return self.number:sub(1, 3)
end

function PhoneNumber.__tostring(phone)
    return string.format("(%s) %s-%s", phone:areaCode(), phone.number:sub(4, 6), phone.number:sub(7))
end

return PhoneNumber
