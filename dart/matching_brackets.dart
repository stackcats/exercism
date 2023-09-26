class MatchingBrackets {
  bool isPaired(String s) {
    List<String> st = [];
    for (int i = 0; i < s.length; i++) {
      if ('([{'.contains(s[i])) {
        st.add(s[i]);
      } else if (s[i] == ')') {
        if (st.isEmpty || st.last != '(') {
          return false;
        }
        st.removeLast();
      } else if (s[i] == '}') {
        if (st.isEmpty || st.last != '{') {
          return false;
        }
        st.removeLast();
      } else if (s[i] == ']') {
        if (st.isEmpty || st.last != '[') {
          return false;
        }
        st.removeLast();
      }
    }

    return st.isEmpty;
  }
}
