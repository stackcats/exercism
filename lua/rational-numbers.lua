local function gcd(a, b)
    if a % b == 0 then
        return b
    else
        return gcd(b, a % b)
    end
end

local function reduce(a)
    local g = gcd(a[1], a[2])
    return { a[1] // g, a[2] // g }
end

local function add(a, b)
    return reduce({ a[1] * b[2] + a[2] * b[1], a[2] * b[2] })
end

local function subtract(a, b)
    b[1] = b[1] * -1
    return add(a, b)
end

local function multiply(a, b)
    return reduce({ a[1] * b[1], a[2] * b[2] })
end

local function divide(a, b)
    return reduce({ a[1] * b[2], a[2] * b[1] })
end

local function abs(a)
    a[1] = math.abs(a[1])
    a[2] = math.abs(a[2])
    return a
end

local function exp_rational(a, p)
    return reduce({ a[1] ^ p, a[2] ^ p })
end

local function exp_real(p, a)
    return (p ^ a[1]) ^ (1 / a[2])
end

return {
    add = add,
    subtract = subtract,
    multiply = multiply,
    divide = divide,
    abs = abs,
    exp_rational = exp_rational,
    exp_real = exp_real,
    reduce = reduce,
}
