return function(scores)
    local sorted = {}
    table.move(scores, 1, #scores, 1, sorted)
    table.sort(sorted, function(a, b)
        return a > b
    end)
    local top3 = {}
    for i = 1, math.min(3, #sorted) do
        top3[i] = sorted[i]
    end
    return {
        scores = function(_)
            return scores
        end,
        latest = function(_)
            return scores[#scores]
        end,
        personal_best = function(_)
            return top3[1]
        end,
        personal_top_three = function(_)
            return top3
        end,
    }
end

