const std = @import("std");
const mem = std.mem;

/// Encodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    var lst = std.ArrayList(u8).init(allocator);
    defer lst.deinit();

    var ct: u8 = 0;
    for (s) |c| {
        const t = switch (c) {
            'a'...'z' => 'z' - c + 'a',
            'A'...'Z' => 'z' - std.ascii.toLower(c) + 'a',
            '0'...'9' => c,
            else => continue,
        };
        if (ct == 5) {
            try lst.append(' ');
            ct = 0;
        }
        ct += 1;
        try lst.append(t);
    }

    return lst.toOwnedSlice();
}

/// Decodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn decode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    var lst = std.ArrayList(u8).init(allocator);
    defer lst.deinit();

    for (s) |c| {
        const t = switch (c) {
            '0'...'9' => c,
            'a'...'z' => 'a' + 'z' - c,
            else => continue,
        };
        try lst.append(t);
    }
    return lst.toOwnedSlice();
}
