return function(dna)
    local s = ""
    local t = { G = "C", C = "G", T = "A", A = "U" }
    for c in dna:gmatch(".") do
        s = s .. t[c]
    end
    return s
end
