const std = @import("std");
const ascii = std.ascii;
const mem = std.mem;

fn isLetter(s: []const u8, i: usize) bool {
    if (i < s.len and ascii.isAlphanumeric(s[i])) {
        return true;
    }
    if (i > 0 and
        i + 1 < s.len and
        s[i] == '\'' and
        ascii.isAlphanumeric(s[i + 1]) and
        ascii.isAlphanumeric(s[i - 1]))
    {
        return true;
    }
    return false;
}

/// Returns the counts of the words in `s`.
/// Caller owns the returned memory.
pub fn countWords(allocator: mem.Allocator, s: []const u8) !std.StringHashMap(u32) {
    var mp = std.StringHashMap(u32).init(allocator);
    var is_in_word = false;
    var start: usize = 0;
    var end: usize = 0;
    for (0..s.len) |i| {
        if (is_in_word) {
            if (isLetter(s, i)) {
                end += 1;
            } else {
                const lower = try ascii.allocLowerString(allocator, s[start .. end + 1]);
                const entry = try mp.getOrPutValue(lower, 0);
                entry.value_ptr.* += 1;
                is_in_word = false;
                if (entry.value_ptr.* > 1) {
                    allocator.free(lower);
                }
            }
        } else {
            if (isLetter(s, i)) {
                start = i;
                end = i;
                is_in_word = true;
            }
        }
    }
    if (is_in_word) {
        const lower = try ascii.allocLowerString(allocator, s[start .. end + 1]);
        const entry = try mp.getOrPutValue(lower, 0);
        entry.value_ptr.* += 1;
        if (entry.value_ptr.* > 1) {
            allocator.free(lower);
        }
    }
    return mp;
}
