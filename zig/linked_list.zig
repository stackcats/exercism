pub fn LinkedList(comptime T: type) type {
    return struct {
        pub const Node = struct {
            prev: ?*Node = null,
            next: ?*Node = null,
            data: T,
        };

        first: ?*Node = null,
        last: ?*Node = null,
        len: usize = 0,

        const Self = @This();

        pub fn push(self: *Self, node: *Node) void {
            node.prev = self.last;

            if (self.last) |tail| {
                tail.next = node;
            } else {
                self.first = node;
            }
            self.last = node;
            self.len += 1;
        }

        pub fn pop(self: *Self) ?*Node {
            if (self.len == 0) {
                return null;
            }
            self.len -= 1;
            const node = self.last;
            self.last = node.?.prev;
            if (self.last) |tail| {
                tail.next = null;
            } else {
                self.first = null;
            }
            return node;
        }

        pub fn shift(self: *Self) ?*Node {
            if (self.len == 0) {
                return null;
            }
            self.len -= 1;
            const node = self.first;
            self.first = node.?.next;
            if (self.first) |head| {
                head.prev = null;
            } else {
                self.last = null;
            }
            return node;
        }

        pub fn unshift(self: *Self, node: *Node) void {
            node.next = self.first;
            if (self.first) |head| {
                head.prev = node;
            } else {
                self.last = node;
            }
            self.first = node;
            self.len += 1;
        }

        pub fn delete(self: *Self, node: *Node) void {
            var curr: ?*Node = self.first;
            while (curr) |n| : (curr = n.next) {
                if (n == node) {
                    break;
                }
            }
            if (curr) |n| {
                self.len -= 1;
                const prev = n.prev;
                const next = n.next;
                if (prev) |p| {
                    p.next = next;
                } else {
                    self.first = next;
                }
                if (next) |p| {
                    p.prev = prev;
                } else {
                    self.last = prev;
                }
            }
        }
    };
}
