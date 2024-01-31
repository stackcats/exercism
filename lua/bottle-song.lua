local BottleSong = {}

local numbers = { "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten" }

numbers[0] = "no"

local function s(bottles)
    if bottles == 1 then
        return "bottle"
    else
        return "bottles"
    end
end

local function verse(bottles)
    return {
        numbers[bottles] .. " green " .. s(bottles) .. " hanging on the wall,\n",
        numbers[bottles] .. " green " .. s(bottles) .. " hanging on the wall,\n",
        "And if one green bottle should accidentally fall,\n",
        "There'll be " .. numbers[bottles - 1]:lower() .. " green " .. s(bottles - 1) .. " hanging on the wall.\n",
    }
end

function BottleSong.recite(start_bottles, take_down)
    local t = {}
    for _ = take_down, 1, -1 do
        local o = verse(start_bottles)
        if #t > 0 then
            table.insert(t, "\n")
        end
        for _, v in ipairs(o) do
            table.insert(t, v)
        end

        start_bottles = start_bottles - 1
    end

    return table.concat(t)
end

return BottleSong

