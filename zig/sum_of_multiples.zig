const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    var mp = std.AutoHashMap(u32, void).init(allocator);
    defer mp.deinit();
    var ans: u64 = 0;
    for (factors) |f| {
        if (f == 0) {
            continue;
        }
        var n = f;
        while (n < limit) : (n += f) {
            const v = try mp.getOrPut(n);
            if (!v.found_existing) {
                ans += n;
            }
        }
    }
    return ans;
}
