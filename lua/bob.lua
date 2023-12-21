local bob = {}

function bob.hey(say)
    say = say:gsub("%s+", "")
    if say == "" then
        return "Fine, be that way."
    end
    local is_question = say:sub(-1) == "?"
    local is_yell = say:upper() == say
    if is_question and is_yell then
        return "Calm down, I know what I'm doing!"
    end
    if is_question then
        return "Sure"
    end
    if is_yell then
        return "Whoa, chill out!"
    end
    return "Whatever"
end

return bob
