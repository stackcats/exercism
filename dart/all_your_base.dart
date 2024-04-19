class AllYourBase {
  List<int> rebase(int base, List<int> arr, int targetBase) {
    if (base < 2 || targetBase < 2) {
      throw ArgumentError("invalid");
    }

    int n = 0;
    for (final d in arr) {
      if (d < 0 || d >= base) {
        throw ArgumentError("invalid");
      }
      n = n * base + d;
    }

    if (n == 0) {
      return [0];
    }

    final List<int> res = [];
    while (n > 0) {
      res.add(n % targetBase);
      n ~/= targetBase;
    }

    return res.reversed.toList();
  }
}
