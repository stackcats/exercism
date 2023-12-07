local Darts = {}

function Darts.score(x, y)
    local d = (x * x + y * y) ^ 0.5
    if d > 10 then
        return 0
    elseif d > 5 then
        return 1
    elseif d > 1 then
        return 5
    else
        return 10
    end
end

return Darts
