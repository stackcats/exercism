EAST = 2
NORTH = 1
WEST = 0
SOUTH = 3


class Robot:

    def __init__(self, direction=NORTH, x_pos=0, y_pos=0):
        self.direction = direction
        self.x = x_pos
        self.y = y_pos

    @property
    def coordinates(self):
        return (self.x, self.y)

    def move(self, ins):
        for c in ins:
            if c == 'R':
                self.turn_right()
            elif c == 'L':
                self.turn_left()
            else:
                self.forward()
        return

    def forward(self):
        (dx, dy) = [(-1, 0), (0, 1), (1, 0), (0, -1)][self.direction]
        self.x += dx
        self.y += dy

    def turn_right(self):
        self.direction = (self.direction + 1) % 4

    def turn_left(self):
        self.direction = (self.direction + 4 - 1) % 4
