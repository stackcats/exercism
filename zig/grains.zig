const math = @import("std").math;

pub const ChessboardError = error{
    IndexOutOfBounds,
};

pub fn square(index: usize) ChessboardError!u64 {
    if (index == 0 or index > 64) {
        return ChessboardError.IndexOutOfBounds;
    }
    const i: u6 = @intCast(index - 1);
    return @as(u64, 1) << i;
}

pub fn total() u64 {
    return math.maxInt(u64);
}
