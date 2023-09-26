class Triangle {
  bool isValid(double a, double b, double c) {
    return a > 0 && b > 0 && c > 0 && a + b >= c && a + c >= b && b + c >= a;
  }

  bool equilateral(double a, double b, double c) {
    return isValid(a, b, c) && a == b && b == c;
  }

  bool isosceles(double a, double b, double c) {
    return isValid(a, b, c) && (a == b || b == c || a == c);
  }

  bool scalene(double a, double b, double c) {
    return isValid(a, b, c) && !isosceles(a, b, c);
  }
}
