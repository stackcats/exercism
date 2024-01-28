return function(n)
    return coroutine.create(function()
        local t = {}
        for i = 2, n do
            if not t[i] then
                coroutine.yield(i)
                for k = i + i, n, i do
                    t[k] = true
                end
            end
        end
    end)
end
