const std = @import("std");
const mem = std.mem;

pub fn isBalanced(allocator: mem.Allocator, s: []const u8) !bool {
    var st = std.ArrayList(u8).init(allocator);
    defer st.deinit();
    for (s) |c| {
        switch (c) {
            '[' => try st.append(']'),
            '{' => try st.append('}'),
            '(' => try st.append(')'),
            ']', '}', ')' => if (st.popOrNull() != c) return false,
            else => {},
        }
    }
    return st.items.len == 0;
}
