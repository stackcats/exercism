// Take a look at the tests, you might have to change the function arguments

pub fn binarySearch(comptime T: type, target: T, items: []const T) ?usize {
    if (items.len == 0) {
        return null;
    }
    var i: usize = 0;
    var j: usize = items.len - 1;
    while (i <= j) {
        const m = i + (j - i) / 2;
        if (items[m] == target) {
            return m;
        }
        if (items[m] < target) {
            i = m + 1;
        } else if (m > 0) {
            j = m - 1;
        } else {
            return null;
        }
    }
    return null;
}
