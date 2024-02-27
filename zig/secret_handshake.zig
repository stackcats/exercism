const std = @import("std");
const mem = std.mem;

pub const Signal = enum(u5) {
    wink = 1,
    double_blink = 2,
    close_your_eyes = 4,
    jump = 8,
};

pub fn calculateHandshake(allocator: mem.Allocator, number: u5) mem.Allocator.Error![]const Signal {
    var arr = std.ArrayList(Signal).init(allocator);
    defer arr.deinit();

    for (std.enums.values(Signal)) |s| {
        if (number & @intFromEnum(s) != 0) {
            try arr.append(s);
        }
    }

    const s = try arr.toOwnedSlice();
    if (number & 16 != 0) {
        mem.reverse(Signal, s);
    }
    return s;
}
