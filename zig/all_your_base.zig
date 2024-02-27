const std = @import("std");
const mem = std.mem;

pub const ConversionError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

/// Converts `digits` from `input_base` to `output_base`, returning a slice of digits.
/// Caller owns the returned memory.
pub fn convert(
    allocator: mem.Allocator,
    digits: []const u32,
    input_base: u32,
    output_base: u32,
) (mem.Allocator.Error || ConversionError)![]u32 {
    if (input_base < 2) {
        return error.InvalidInputBase;
    }

    if (output_base < 2) {
        return error.InvalidOutputBase;
    }

    var n: u32 = 0;
    for (digits) |d| {
        if (d >= input_base) {
            return error.InvalidDigit;
        }
        n = n * input_base + d;
    }

    if (n == 0) {
        return try allocator.dupe(u32, &.{0});
    }

    var arr = std.ArrayList(u32).init(allocator);
    defer arr.deinit();
    while (n != 0) : (n /= output_base) {
        try arr.append(n % output_base);
    }

    const s = try arr.toOwnedSlice();
    mem.reverse(u32, s);
    return s;
}
