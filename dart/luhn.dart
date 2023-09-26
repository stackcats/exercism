class Luhn {
  bool valid(String s) {
    s = s.replaceAll(' ', '');
    if (s.length == 1) return false;
    if (RegExp(r'[^0-9]').hasMatch(s)) return false;

    int sum = 0;
    for (int i = 1; i <= s.length; i++) {
      int n = int.parse(s[s.length - i]);
      if (i.isEven) {
        n *= 2;
        if (n > 9) {
          n -= 9;
        }
      }
      sum += n;
    }
    return sum % 10 == 0;
  }
}
