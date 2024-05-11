class EggCounter {
  int count(int n) {
    int ct = 0;

    while (n > 0) {
      ct += n % 2;
      n ~/= 2;
    }

    return ct;
  }
}
