return {
    transform = function(dataset)
        local t = {}
        for k, tt in pairs(dataset) do
            for _, v in ipairs(tt) do
                t[v:lower()] = k
            end
        end
        return t
    end,
}
