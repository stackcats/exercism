class WordCount {
  Map<String, int> countWords(String s) {
    Map<String, int> mp = {};
    String word = '';
    RegExp exp = RegExp(r'[A-Za-z0-9]');
    s = s.toLowerCase();
    for (int i = 0; i < s.length; i++) {
      if (exp.hasMatch(s[i])) {
        word += s[i];
      } else if (s[i] == "'") {
        if (i - 1 >= 0 && i + 1 < s.length) {
          if (exp.hasMatch(s[i - 1]) && exp.hasMatch(s[i + 1])) {
            word += "'";
          }
        }
      } else {
        mp[word] = (mp[word] ?? 0) + 1;
        word = '';
      }
    }
    mp[word] = (mp[word] ?? 0) + 1;
    mp.remove('');
    return mp;
  }
}
