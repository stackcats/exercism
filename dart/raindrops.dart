class Raindrops {
  String convert(int n) {
    String s = '';
    if (n % 3 == 0) {
      s += 'Pling';
    }
    if (n % 5 == 0) {
      s += 'Plang';
    }
    if (n % 7 == 0) {
      s += 'Plong';
    }
    return s == '' ? '$n' : s;
  }
}
