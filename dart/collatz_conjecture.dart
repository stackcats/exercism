class CollatzConjecture {
  int steps(int n) {
    if (n < 1) {
      throw ArgumentError('Only positive integers are allowed');
    }
    int ct = 0;
    while (n != 1) {
      if (n.isOdd) {
        n = n * 3 + 1;
      } else {
        n ~/= 2;
      }
      ct++;
    }
    return ct;
  }
}
