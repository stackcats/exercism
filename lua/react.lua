local function InputCell(value)
    local linked = {}
    return {
        get_value = function()
            return value
        end,
        set_value = function(val)
            value = val
            for _, each in ipairs(linked) do
                each.propagate()
            end
            for _, each in ipairs(linked) do
                each.update()
            end
        end,
        link = function(other)
            table.insert(linked, other)
        end,
    }
end

local function ComputeCell(...)
    local inputs = { ... }
    local f = table.remove(inputs)
    local linked = {}
    local value
    local prev_value
    local callbacks = {}

    local cell = {}

    local function get_value()
        local vs = {}
        for _, input in ipairs(inputs) do
            table.insert(vs, input.get_value())
        end
        return f(table.unpack(vs))
    end

    function cell.get_value()
        return value
    end

    function cell.watch(cb)
        table.insert(callbacks, cb)
    end

    function cell.unwatch(cb)
        for i, c in ipairs(callbacks) do
            if c == cb then
                table.remove(callbacks, i)
                return
            end
        end
    end

    function cell.propagate()
        value = get_value()
        for _, each in ipairs(linked) do
            each.propagate()
        end
    end

    function cell.update()
        if prev_value ~= value then
            prev_value = value
            for _, cb in ipairs(callbacks) do
                cb(value)
            end
        end
        for _, each in ipairs(linked) do
            each.update()
        end
    end

    function cell.link(other)
        table.insert(linked, other)
    end

    value = get_value()
    prev_value = value

    for _, input in ipairs(inputs) do
        input.link(cell)
    end

    return cell
end

local function Reactor()
    return {
        InputCell = InputCell,
        ComputeCell = ComputeCell,
    }
end

return { Reactor = Reactor }

