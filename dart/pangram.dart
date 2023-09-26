class Pangram {
  bool isPangram(String s) {
    final st = s
        .toLowerCase()
        .split('')
        .where((c) => RegExp(r'[a-zA-Z]').hasMatch(c))
        .toSet();
    return st.length == 26;
  }
}
