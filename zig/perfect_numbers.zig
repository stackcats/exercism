pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

/// Asserts that `n` is nonzero.
pub fn classify(n: u64) Classification {
    var sum: u64 = 0;
    for (1..n) |i| {
        if (n % i == 0) {
            sum += i;
        }
    }

    if (sum < n) {
        return .deficient;
    }
    if (sum == n) {
        return .perfect;
    }
    return .abundant;
}
