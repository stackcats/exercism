import 'package:yacht/categories.dart';
import 'package:collection/collection.dart';

class Yacht {
  List<int> dice;
  final Map<int, int> counter = {};

  Yacht(this.dice) {
    for (final d in this.dice) {
      counter[d] = (counter[d] ?? 0) + 1;
    }
    dice.sort();
  }

  bool findCount(int n) {
    return counter.values.any((v) => v == n);
  }

  int score(Category category) {
    if (category.index <= Category.sixes.index) {
      final n = category.index + 1;
      return (counter[n] ?? 0) * n;
    }

    if (category == Category.yacht && findCount(5)) {
      return 50;
    }

    if (category == Category.full_house && findCount(3) && findCount(2)) {
      return dice.sum;
    }

    if (category == Category.four_of_a_kind) {
      for (final MapEntry(:key, :value) in counter.entries) {
        if (value >= 4) {
          return key * 4;
        }
      }
    }

    if (category == Category.little_straight &&
        ListEquality().equals(dice, [1, 2, 3, 4, 5])) {
      return 30;
    }

    if (category == Category.big_straight &&
        ListEquality().equals(dice, [2, 3, 4, 5, 6])) {
      return 30;
    }

    if (category == Category.choice) {
      return dice.sum;
    }
    return 0;
  }
}
