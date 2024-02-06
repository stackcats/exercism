local t = {
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    "eleven",
    "twelve",
    "thirteen",
    "fourteen",
    "fifteen",
    "sixteen",
    "seventeen",
    "eighteen",
    "nineteen",
    "twenty",
}

t[0] = "zero"
t[30] = "thirty"
t[40] = "forty"
t[50] = "fifty"
t[60] = "sixty"
t[70] = "seventy"
t[80] = "eighty"
t[90] = "ninety"

return function(n)
    if n < 0 or n > 999999999999 then
        return -1
    end

    local arr = {}
    while n > 0 do
        local rem = n % 1000
        table.insert(arr, rem)
        n = n // 1000
    end

    local scales = { "", "thousand", "million", "billion" }
    local ans = {}
    for i = 4, 1, -1 do
        if i > #arr then
            goto continue
        end

        local chunk = arr[i]

        if chunk == 0 then
            goto continue
        end

        local a = chunk // 100

        if a > 0 then
            table.insert(ans, t[a] .. " hundred")
        end

        local b = chunk % 100
        if b > 0 then
            if t[b] == nil then
                local c = b % 10
                b = b // 10 * 10
                table.insert(ans, t[b] .. "-" .. t[c])
            else
                table.insert(ans, t[b])
            end
        end

        if i > 1 then
            table.insert(ans, scales[i])
        end

        ::continue::
    end

    local s = table.concat(ans, " ")
    return s == "" and "zero" or s
end

