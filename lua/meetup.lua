local wday = {
    Sunday = 1,
    Monday = 2,
    Tuesday = 3,
    Wednesday = 4,
    Thursday = 5,
    Friday = 6,
    Saturday = 7,
}

local index = {
    first = 1,
    second = 2,
    third = 3,
    fourth = 4,
    fifth = 5,
}

return function(config)
    local t1 = os.time({
        year = config.year,
        month = config.month,
        day = 1,
    })

    local d = os.date("*t", t1)
    d.month = d.month + 1
    d.day = d.day - 1

    local t2 = os.time(d)

    local arr = {}
    local one_day = 60 * 60 * 24
    for t = t1, t2, one_day do
        local d = os.date("*t", t)
        if d.wday == wday[config.day] then
            table.insert(arr, d.day)
        end
    end
    if config.week == "teenth" then
        for _, day in ipairs(arr) do
            if day >= 13 and day <= 19 then
                return day
            end
        end
    end

    index.last = #arr
    return arr[index[config.week]]
end

