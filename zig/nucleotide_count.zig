pub const NucleotideError = error{Invalid};

pub const Counts = struct {
    a: u32 = 0,
    c: u32 = 0,
    g: u32 = 0,
    t: u32 = 0,
};

pub fn countNucleotides(s: []const u8) NucleotideError!Counts {
    var ct = Counts{};
    for (s) |c| {
        switch (c) {
            'A' => ct.a += 1,
            'C' => ct.c += 1,
            'G' => ct.g += 1,
            'T' => ct.t += 1,
            else => return NucleotideError.Invalid,
        }
    }
    return ct;
}
