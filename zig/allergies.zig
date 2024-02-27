const std = @import("std");
const EnumSet = std.EnumSet;

pub const Allergen = enum(u8) {
    eggs = 1,
    peanuts = 2,
    shellfish = 4,
    strawberries = 8,
    tomatoes = 16,
    chocolate = 32,
    pollen = 64,
    cats = 128,
};

pub fn isAllergicTo(score: u8, allergen: Allergen) bool {
    return score & @intFromEnum(allergen) != 0;
}

pub fn initAllergenSet(score: usize) EnumSet(Allergen) {
    var st = EnumSet(Allergen).init(.{});
    for (std.enums.values(Allergen)) |a| {
        if (isAllergicTo(@truncate(score), a)) {
            st.insert(a);
        }
    }
    return st;
}
