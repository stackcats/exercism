const std = @import("std");
const ascii = std.ascii;
const mem = std.mem;

pub fn abbreviate(allocator: mem.Allocator, words: []const u8) mem.Allocator.Error![]u8 {
    var arr = std.ArrayList(u8).init(allocator);
    defer arr.deinit();

    var is_in_word = false;
    for (words) |c| {
        if (is_in_word) {
            if (!ascii.isAlphabetic(c) and c != '\'') {
                is_in_word = false;
            }
        } else {
            if (ascii.isAlphabetic(c)) {
                is_in_word = true;
                try arr.append(ascii.toUpper(c));
            }
        }
    }
    return arr.toOwnedSlice();
}
