const std = @import("std");

pub fn isValidIsbn10(s: []const u8) bool {
    var i: i32 = 10;
    var sum: i32 = 0;
    for (s) |c| {
        const t = std.ascii.toLower(c);
        switch (t) {
            '0'...'9' => {
                const d: i32 = @intCast(t - '0');
                sum += d * i;
                i -= 1;
            },
            'x' => {
                if (i != 1) {
                    return false;
                }
                sum += 10 * i;
                i -= 1;
            },
            '-' => {},
            else => return false,
        }
    }
    return i == 0 and @mod(sum, 11) == 0;
}
