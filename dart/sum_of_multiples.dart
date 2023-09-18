class SumOfMultiples {
  int sum(List<int> arr, int limit) {
    Set<int> st = Set();
    arr.forEach((n) {
      if (n == 0) {
        return;
      }
      for (int i = n; i < limit; i += n) {
        st.add(i);
      }
    });

    if (st.isEmpty) {
      return 0;
    }
    return st.reduce((a, b) => a + b);
  }
}
