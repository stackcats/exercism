local SquareRoot = {}

function SquareRoot.square_root(radicand)
    local i = 1
    while i * i ~= radicand do
        i = i + 1
    end
    return i
end

return SquareRoot
