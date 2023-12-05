local ArmstrongNumbers = {}

function ArmstrongNumbers.is_armstrong_number(number)
    local len = #tostring(number)
    local sum = 0
    local curr = number
    while curr ~= 0 do
        sum = sum + (curr % 10) ^ len
        curr = curr // 10
    end
    return sum == number
end

return ArmstrongNumbers
