return function(s)
    local mp = {}
    for c in string.lower(s):gmatch("%a") do
        if mp[c] then
            return false
        end
        mp[c] = true
    end

    return true
end
