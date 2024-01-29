return function(amount, values)
    local dp = {}
    local changed = {}
    dp[0] = 0
    for n = 1, amount do
        for i, v in ipairs(values) do
            local rem = n - v
            if dp[rem] and dp[rem] + 1 < (dp[n] or math.huge) then
                dp[n] = dp[rem] + 1
                changed[n] = i
            end
        end
    end

    if changed[amount] == nil then
        return nil
    end

    local t = {}
    for i = 1, #values do
        t[i] = 0
    end

    while amount > 0 do
        local i = changed[amount]
        t[i] = t[i] + 1
        amount = amount - values[i]
    end

    return t
end
