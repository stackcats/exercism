return function()
    local rolls = {}
    return {
        roll = function(pins)
            assert(pins >= 0 and pins <= 10)
            if #rolls == 20 then
                assert(rolls[19] + rolls[20] == 10)
            end
            if pins == 10 then
                table.insert(rolls, pins)
                table.insert(rolls, 0)
            elseif #rolls % 2 ~= 0 then
                assert(rolls[#rolls] + pins <= 10)
                table.insert(rolls, pins)
            else
                table.insert(rolls, pins)
            end
        end,
        score = function()
            if #rolls == 24 then
                assert(rolls[23] == 10 and rolls[21] == 10)
            elseif #rolls == 22 then
                assert(
                    (rolls[19] == 10 and rolls[21] ~= 10)
                    or (rolls[19] ~= 10 and rolls[19] + rolls[20] == 10 and rolls[21] == 10)
                )
            elseif #rolls == 21 then
                assert(rolls[19] + rolls[20] == 10)
            else
                assert(#rolls == 20)
            end

            local s = 0
            for f = 1, 10 do
                local i = 2 * f - 1
                if rolls[i] == 10 then
                    s = s + 10 + rolls[i + 2]
                    s = s + (rolls[i + 2] == 10 and rolls[i + 4] or rolls[i + 3])
                    i = i + 2
                elseif rolls[i] + rolls[i + 1] == 10 then
                    s = s + 10 + rolls[i + 2]
                    i = i + 2
                else
                    s = s + rolls[i] + rolls[i + 1]
                    i = i + 2
                end
            end
            return s
        end,
    }
end

