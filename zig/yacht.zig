pub const Category = enum {
    ones,
    twos,
    threes,
    fours,
    fives,
    sixes,
    full_house,
    four_of_a_kind,
    little_straight,
    big_straight,
    choice,
    yacht,
};

pub fn score(dice: [5]u3, category: Category) u32 {
    var arr: [6]u32 = [_]u32{ 0, 0, 0, 0, 0, 0 };
    var sum: u32 = 0;
    for (dice) |d| {
        arr[d - 1] += 1;
        sum += d;
    }

    return switch (category) {
        .full_house => {
            var has_2 = false;
            var has_3 = false;
            for (arr) |a| {
                if (a == 2) {
                    has_2 = true;
                } else if (a == 3) {
                    has_3 = true;
                }
            }
            return if (has_2 and has_3) sum else 0;
        },
        .four_of_a_kind => {
            for (arr, 0..) |a, i| {
                if (a >= 4) {
                    const d: u32 = @intCast(i + 1);
                    return 4 * d;
                }
            }
            return 0;
        },
        .little_straight => if (sum == 15) 30 else 0,
        .big_straight => if (sum == 20) 30 else 0,
        .choice => sum,
        .yacht => {
            for (arr) |a| {
                if (a == 5) {
                    return 50;
                }
            }
            return 0;
        },
        else => {
            const id = @intFromEnum(category);
            return (id + 1) * arr[id];
        },
    };
}
