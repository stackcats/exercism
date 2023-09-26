class Isogram {
  bool isIsogram(String s) {
    s = s.replaceAll(RegExp(r'[- ]'), '').toLowerCase();
    final st = s.split('').toSet();
    return st.length == s.length;
  }
}
