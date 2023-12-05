local Hamming = {}

function Hamming.compute(a, b)
    if #a ~= #b then
        return -1
    end

    local ct = 0

    for i = 1, #a do
        if a:byte(i) ~= b:byte(i) then
            ct = ct + 1
        end
    end

    return ct
end

return Hamming
