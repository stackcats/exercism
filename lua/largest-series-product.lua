return function(config)
    assert(config.span >= 0)
    assert(#config.digits >= config.span)
    if config.digits:match("[^%d]") then
        error("Invalid digits")
    end

    local ans = 0
    for i = 1, #config.digits - config.span + 1 do
        local s = config.digits:sub(i, i + config.span - 1)
        local p = 1
        for c in s:gmatch(".") do
            p = p * (c - "0")
        end
        ans = math.max(ans, p)
    end

    return ans
end
