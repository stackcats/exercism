local function to_nodes(tree, nodes)
    assert(#tree > 0)
    local parent = tree[1]
    nodes[parent] = nodes[parent] or {}

    for _, child in ipairs(tree[2] or {}) do
        table.insert(nodes[parent], child[1])
        to_nodes(child, nodes)
        table.insert(nodes[child[1]], parent)
    end
end

local function build_tree(nodes, curr, parent)
    local t = { curr }
    for _, node in ipairs(nodes[curr]) do
        if node ~= parent then
            t[2] = t[2] or {}
            table.insert(t[2], build_tree(nodes, node, curr))
        end
    end
    return t
end

local function pov_from(node_name)
    return {
        of = function(tree)
            local nodes = {}
            to_nodes(tree, nodes)
            assert(nodes[node_name])
            return build_tree(nodes, node_name, nil)
        end,
    }
end

local function dfs(nodes, curr, target, visited)
    if curr == target then
        return { target }
    end

    if visited[curr] ~= nil then
        return nil
    end
    visited[curr] = 1
    for _, each in ipairs(nodes[curr]) do
        local p = dfs(nodes, each, target, visited)
        if p ~= nil then
            table.insert(p, 1, curr)
            return p
        end
    end
    return nil
end

local function path_from(source)
    return {
        to = function(target)
            return {
                of = function(tree)
                    local nodes = {}
                    to_nodes(tree, nodes)
                    assert(nodes[source] and nodes[target])
                    return dfs(nodes, source, target, {})
                end,
            }
        end,
    }
end

return { pov_from = pov_from, path_from = path_from }

