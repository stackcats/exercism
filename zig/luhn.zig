const std = @import("std");

pub fn isValid(s: []const u8) bool {
    if (s.len < 2) {
        return false;
    }
    var sum: u32 = 0;
    var i: usize = s.len;
    var p: u32 = 0;
    while (i > 0) : (i -= 1) {
        const c = s[i - 1];
        if (c == ' ') {
            continue;
        }
        if (!std.ascii.isDigit(c)) {
            return false;
        }
        var n: u8 = @intCast(c - '0');
        if (p % 2 == 1) {
            n *= 2;
            if (n > 9) {
                n -= 9;
            }
        }
        sum += n;
        p += 1;
    }
    return p > 1 and sum % 10 == 0;
}
