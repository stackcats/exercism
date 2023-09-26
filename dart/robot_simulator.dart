import './position.dart';
import './orientation.dart';

class Robot {
  Position position;
  Orientation orientation;

  Robot(this.position, this.orientation);

  void move(String cmd) {
    for (int i = 0; i < cmd.length; i++) {
      if (cmd[i] == 'A') {
        int dx = 0;
        int dy = 0;
        switch (orientation) {
          case Orientation.north:
            dy = 1;
            break;
          case Orientation.east:
            dx = 1;
            break;
          case Orientation.south:
            dy = -1;
            break;
          case Orientation.west:
            dx = -1;
            break;
        }
        position.x += dx;
        position.y += dy;
      } else if (cmd[i] == 'L') {
        orientation = Orientation.values[
            (orientation.index - 1 + Orientation.values.length) %
                Orientation.values.length];
      } else {
        orientation = Orientation
            .values[(orientation.index + 1) % Orientation.values.length];
      }
    }
  }
}
