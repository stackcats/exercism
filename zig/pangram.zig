const ascii = @import("std").ascii;

pub fn isPangram(str: []const u8) bool {
    var bit: u32 = 0;
    for (str) |c| {
        if (ascii.isAlphabetic(c)) {
            bit |= @as(u32, 1) << @truncate(ascii.toLower(c) - 'a');
        }
    }
    return bit == 0x3ffffff;
}
