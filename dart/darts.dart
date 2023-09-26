import 'dart:math';

class Darts {
  int score(double x, double y) {
    double distance = sqrt(x * x + y * y);
    if (distance <= 1) return 10;
    if (distance <= 5) return 5;
    if (distance <= 10) return 1;
    return 0;
  }
}
