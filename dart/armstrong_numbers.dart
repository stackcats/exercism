import 'dart:math';

class ArmstrongNumbers {
  bool isArmstrongNumber(String s) {
    num m = 0;
    s.runes.forEach((c) {
      int n = int.parse(String.fromCharCode(c));
      m += pow(n, s.length);
    });
    return m == int.parse(s);
  }
}
