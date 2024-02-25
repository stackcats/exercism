const std = @import("std");

pub fn convert(buffer: []u8, n: u32) []const u8 {
    const arr = [3]struct { u32, []const u8 }{
        .{ 3, "Pling" },
        .{ 5, "Plang" },
        .{ 7, "Plong" },
    };

    var stream = std.io.fixedBufferStream(buffer);
    for (arr) |each| {
        if (n % each[0] == 0) {
            _ = stream.writer().write(each[1]) catch unreachable;
        }
    }
    if (stream.pos == 0) {
        _ = stream.writer().print("{d}", .{n}) catch unreachable;
    }
    return stream.getWritten();
}
