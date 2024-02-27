pub fn primes(buffer: []u32, limit: u32) []u32 {
    var arr: [1024]bool = undefined;
    @memset(&arr, true);

    var j: u32 = 0;
    for (2..(limit + 1)) |i| {
        if (!arr[i]) {
            continue;
        }
        buffer[j] = @intCast(i);
        j += 1;
        var k = i * i;
        while (k <= limit) : (k += i) {
            arr[k] = false;
        }
    }

    return buffer[0..j];
}
