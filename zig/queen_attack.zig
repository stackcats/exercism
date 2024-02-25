const math = @import("std").math;

pub const QueenError = error{
    InitializationFailure,
};

pub const Queen = struct {
    x: i8,
    y: i8,
    pub fn init(x: i8, y: i8) QueenError!Queen {
        if (x < 0 or y < 0 or x >= 8 or y >= 8) {
            return QueenError.InitializationFailure;
        }
        return Queen{
            .x = x,
            .y = y,
        };
    }

    pub fn canAttack(self: Queen, other: Queen) QueenError!bool {
        return self.x == other.x or self.y == other.y or math.absCast(self.x - other.x) == math.absCast(self.y - other.y);
    }
};
