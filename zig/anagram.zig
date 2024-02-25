const std = @import("std");
const ascii = std.ascii;
const mem = std.mem;

fn eql(a: []const u8, b: []const u8) bool {
    if (a.len != b.len) {
        return false;
    }
    for (a, b) |x, y| {
        if (ascii.toLower(x) != ascii.toLower(y)) {
            return false;
        }
    }
    return true;
}

fn isAnagram(a: []const u8, b: []const u8) bool {
    if (a.len != b.len) return false;
    if (eql(a, b)) return false;
    var ca = [_]u32{0} ** 26;
    var cb = [_]u32{0} ** 26;
    for (a, b) |c1, c2| {
        ca[ascii.toLower(c1) - 'a'] += 1;
        cb[ascii.toLower(c2) - 'a'] += 1;
    }
    return mem.eql(u32, &ca, &cb);
}

/// Returns the set of strings in `candidates` that are anagrams of `word`.
/// Caller owns the returned memory.
pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) !std.BufSet {
    var bs = std.BufSet.init(allocator);

    for (candidates) |c| {
        if (isAnagram(c, word)) {
            try bs.insert(c);
        }
    }
    return bs;
}
