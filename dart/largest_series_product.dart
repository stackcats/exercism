import 'dart:math';

class LargestSeriesProduct {
  int largestProduct(input, span) {
    if (span < 0) {
      throw ArgumentError('span must not be negative');
    }
    if (input.length < span) {
      throw ArgumentError('span must be smaller than string length');
    }

    final List<int> lst = [];
    for (int i = 0; i < input.length; i++) {
      final n = int.tryParse(input[i]);
      if (n == null) {
        throw ArgumentError('digits input must only contain digits');
      }
      lst.add(n);
    }

    int res = 0;
    for (int i = 0; i < lst.length - span + 1; i += 1) {
      int r = 1;
      for (int j = 0; j < span; j++) {
        r *= lst[i + j];
      }
      res = max(res, r);
    }
    return res;
  }
}
