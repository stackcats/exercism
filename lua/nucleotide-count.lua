local DNA = {}
DNA.__index = DNA

function DNA:new(s)
    if s:match("[^ATCG]") then
        return error("Invalid Sequence")
    end
    local t = { nucleotideCounts = { A = 0, T = 0, C = 0, G = 0 } }
    for c in s:gmatch(".") do
        t.nucleotideCounts[c] = t.nucleotideCounts[c] + 1
    end
    setmetatable(t, self)
    return t
end

function DNA:count(c)
    local ct = self.nucleotideCounts[c]
    assert(ct, "Invalid Nucleotide")
    return ct
end

return DNA
