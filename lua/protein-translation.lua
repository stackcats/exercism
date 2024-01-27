local t = {
    AUG = "Methionine",
    UUU = "Phenylalanine",
    UUC = "Phenylalanine",
    UUA = "Leucine",
    UUG = "Leucine",
    UCU = "Serine",
    UCC = "Serine",
    UCA = "Serine",
    UCG = "Serine",
    UAU = "Tyrosine",
    UAC = "Tyrosine",
    UGU = "Cysteine",
    UGC = "Cysteine",
    UGG = "Tryptophan",
    UAA = "STOP",
    UAG = "STOP",
    UGA = "STOP",
}
local function translate_codon(codon)
    assert(t[codon], "nil")
    return t[codon]
end

local function translate_rna_strand(rna_strand)
    local arr = {}
    for i = 1, #rna_strand, 3 do
        local s = translate_codon(rna_strand:sub(i, i + 2))
        if s == "STOP" then
            break
        end
        table.insert(arr, s)
    end
    return arr
end

return { codon = translate_codon, rna_strand = translate_rna_strand }

