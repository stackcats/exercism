pub const Coordinate = struct {
    x: f32,
    y: f32,
    pub fn init(x_coord: f32, y_coord: f32) Coordinate {
        return Coordinate{
            .x = x_coord,
            .y = y_coord,
        };
    }
    pub fn score(self: Coordinate) usize {
        const dis = self.x * self.x + self.y * self.y;
        if (dis > 100) {
            return 0;
        }
        if (dis > 25) {
            return 1;
        }
        if (dis > 1) {
            return 5;
        }
        return 10;
    }
};
