return function(pos)
    if pos.row < 0 or pos.row > 7 or pos.column < 0 or pos.column > 7 then
        return error("wrong arguments")
    end

    return {
        row = pos.row,
        column = pos.column,
        can_attack = function(other)
            return pos.row == other.row
                or pos.column == other.column
                or math.abs(pos.row - other.row) == math.abs(pos.column - other.column)
        end,
    }
end
