const std = @import("std");

pub fn response(s: []const u8) []const u8 {
    const trimmed = std.mem.trim(u8, s, &std.ascii.whitespace);
    if (trimmed.len == 0) {
        return "Fine. Be that way!";
    }

    const isQuestion = trimmed[trimmed.len - 1] == '?';

    var isYelling = false;
    for (trimmed) |c| {
        if (std.ascii.isLower(c)) {
            isYelling = false;
            break;
        }
        if (std.ascii.isUpper(c)) {
            isYelling = true;
        }
    }

    if (isQuestion and isYelling) {
        return "Calm down, I know what I'm doing!";
    }
    if (isQuestion) {
        return "Sure.";
    }
    if (isYelling) {
        return "Whoa, chill out!";
    }
    return "Whatever.";
}
