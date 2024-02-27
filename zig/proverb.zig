const std = @import("std");
const mem = std.mem;
const fmt = std.fmt;

pub fn recite(allocator: mem.Allocator, words: []const []const u8) (fmt.AllocPrintError || mem.Allocator.Error)![][]u8 {
    var lst = try allocator.alloc([]u8, words.len);
    if (words.len == 0) {
        return lst;
    }

    for (1..words.len) |i| {
        lst[i - 1] = try fmt.allocPrint(
            allocator,
            "For want of a {s} the {s} was lost.\n",
            .{ words[i - 1], words[i] },
        );
    }

    lst[lst.len - 1] = try fmt.allocPrint(
        allocator,
        "And all for the want of a {s}.\n",
        .{words[0]},
    );
    return lst;
}
