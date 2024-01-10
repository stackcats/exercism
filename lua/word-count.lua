local function word_count(s)
    local t = {}
    for w in s:gmatch("%w['%w]*") do
        local x = w:lower():gsub("'$", "")
        t[x] = (t[x] or 0) + 1
    end
    return t
end

return {
    word_count = word_count,
}

