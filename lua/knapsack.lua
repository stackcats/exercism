local function maximum_value(maximum_weight, items)
    local dp = {}

    for _, item in ipairs(items) do
        for i = maximum_weight, item.weight, -1 do
            dp[i] = math.max((dp[i - item.weight] or 0) + item.value, dp[i] or 0)
        end
    end

    return dp[maximum_weight] or 0
end

return { maximum_value = maximum_value }
