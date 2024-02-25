const std = @import("std");

pub fn isIsogram(str: []const u8) bool {
    var bits: u32 = 0;
    for (str) |c| {
        if (c == ' ' or c == '-') {
            continue;
        }
        const n = @as(u32, 1) << @truncate(std.ascii.toLower(c) - 'a');
        if (bits & n == n) {
            return false;
        }
        bits |= n;
    }
    return true;
}
