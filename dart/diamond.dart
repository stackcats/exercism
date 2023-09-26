class Diamond {
  List<String> rows(String letter) {
    List<String> res = [];

    String ch = 'A';
    int outerLen = diff(letter, ch);

    while (ch.compareTo(letter) < 0) {
      res.add(row(ch, outerLen));
      ch = String.fromCharCode(ch.codeUnitAt(0) + 1);
      outerLen--;
    }

    while (ch.compareTo('A') >= 0) {
      res.add(row(ch, outerLen));
      ch = String.fromCharCode(ch.codeUnitAt(0) - 1);
      outerLen++;
    }
    return res;
  }

  int diff(String a, String b) {
    return a.codeUnitAt(0) - b.codeUnitAt(0);
  }

  String row(String ch, int outerLen) {
    String outer = ' ' * outerLen;
    if (ch == 'A') {
      return '$outer$ch$outer';
    }
    int innerLen = diff(ch, 'A') * 2 - 1;
    String inner = ' ' * innerLen;
    return '$outer$ch$inner$ch$outer';
  }
}
