return function(s)
    local mat = {}
    for row in s:upper():gmatch("%S+") do
        local t = {}
        for c in row:gmatch(".") do
            table.insert(t, c)
        end
        table.insert(mat, t)
    end

    local students = {
        alice = 1,
        bob = 2,
        charlie = 3,
        david = 4,
        eve = 5,
        fred = 6,
        ginny = 7,
        harriet = 8,
        ileana = 9,
        joseph = 10,
        kincaid = 11,
        larry = 12,
    }

    local plants = {
        V = "violets",
        R = "radishes",
        C = "clover",
        G = "grass",
    }

    return setmetatable({}, {
        __index = function(g, name)
            local i = students[name:lower()]
            if i == nil then
                return {}
            end
            local j = (i - 1) * 2
            return { plants[mat[1][j + 1]], plants[mat[1][j + 2]], plants[mat[2][j + 1]], plants[mat[2][j + 2]] }
        end,
    })
end
