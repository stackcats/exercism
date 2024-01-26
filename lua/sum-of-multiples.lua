return function(numbers)
    return {
        to = function(limit)
            local t = {}
            for _, n in ipairs(numbers) do
                local m = n
                while m < limit do
                    t[m] = 1
                    m = m + n
                end
            end
            local ans = 0
            for k, _ in pairs(t) do
                ans = ans + k
            end
            return ans
        end,
    }
end
