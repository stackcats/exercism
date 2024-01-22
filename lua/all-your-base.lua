local all_your_base = {}

all_your_base.convert = function(from_digits, from_base)
    assert(from_base > 1, "invalid input base")

    return {
        to = function(to_base)
            assert(to_base > 1, "invalid output base")
            local n = 0
            local base = 1
            for i = #from_digits, 1, -1 do
                local d = from_digits[i]
                assert(d >= 0, "negative digits are not allowed")
                assert(d < from_base, "digit out of range")
                n = n + d * base
                base = base * from_base
            end
            if n == 0 then
                return { 0 }
            end
            local t = {}
            while n > 0 do
                table.insert(t, 1, n % to_base)
                n = n // to_base
            end
            return t
        end,
    }
end

return all_your_base
