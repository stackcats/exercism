local function points(t)
    return t.w * 3 + t.d * 1
end

return function(results)
    local t = {}
    for _, res in ipairs(results) do
        if res == "" or res:match("[^a-zA-Z ;]") then
            goto continue
        end

        local r = {}
        for each in res:gmatch("[^;@]+") do
            table.insert(r, each)
        end
        local team1, team2, re = table.unpack(r)

        if re ~= "win" and re ~= "draw" and re ~= "loss" then
            goto continue
        end

        if t[team1] == nil then
            t[team1] = {
                w = 0,
                d = 0,
                l = 0,
            }
        end

        if t[team2] == nil then
            t[team2] = {
                w = 0,
                d = 0,
                l = 0,
            }
        end

        if re == "win" then
            t[team1].w = t[team1].w + 1
            t[team2].l = t[team2].l + 1
        elseif re == "loss" then
            t[team1].l = t[team1].l + 1
            t[team2].w = t[team2].w + 1
        else
            t[team1].d = t[team1].d + 1
            t[team2].d = t[team2].d + 1
        end
        ::continue::
    end

    local teams = {}
    for name in pairs(t) do
        table.insert(teams, name)
    end

    table.sort(teams, function(a, b)
        local p1 = points(t[a])
        local p2 = points(t[b])
        if p1 == p2 then
            return a < b
        end
        return points(t[a]) > points(t[b])
    end)

    local res = {
        "Team                           | MP |  W |  D |  L |  P",
    }

    for _, name in ipairs(teams) do
        local mp = t[name].w + t[name].d + t[name].l
        local p = points(t[name])
        local s = string.format("%-31s|%3d |%3d |%3d |%3d |%3d", name, mp, t[name].w, t[name].d, t[name].l, p)
        table.insert(res, s)
    end

    return res
end

