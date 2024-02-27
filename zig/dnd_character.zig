const std = @import("std");

pub fn modifier(score: i8) i8 {
    return @divFloor(score - 10, 2);
}

pub fn ability() i8 {
    var rnd = std.rand.DefaultPrng.init(0);
    var dice = [_]i8{0} ** 4;
    for (0..4) |i| {
        dice[i] = rnd.random().intRangeAtMost(i8, 1, 6);
    }
    var min: i8 = 0;
    var sum: i8 = 0;
    for (dice) |d| {
        sum += d;
        if (min > d) min = d;
    }
    return sum - min;
}

pub const Character = struct {
    strength: i8 = ability(),
    dexterity: i8 = ability(),
    constitution: i8 = ability(),
    intelligence: i8 = ability(),
    wisdom: i8 = ability(),
    charisma: i8 = ability(),
    hitpoints: i8 = undefined,

    pub fn init() Character {
        var character = Character{};
        character.hitpoints = modifier(character.constitution) + 10;
        return character;
    }
};
