local triangle = {}

function triangle.kind(a, b, c)
    assert(valid(a, b, c), "Input Error")
    if a == b and b == c then
        return "equilateral"
    end

    if a == b or a == c or b == c then
        return "isosceles"
    end
    return "scalene"
end

function valid(a, b, c)
    return a > 0 and b > 0 and c > 0 and a + b >= c and b + c >= a and a + c >= b
end

return triangle
