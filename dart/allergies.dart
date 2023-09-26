import 'dart:math';

class Allergies {
  List<String> get items {
    return [
      'eggs',
      'peanuts',
      'shellfish',
      'strawberries',
      'tomatoes',
      'chocolate',
      'pollen',
      'cats'
    ];
  }

  bool allergicTo(String item, int code) {
    return pow(2, items.indexOf(item)).toInt() & code != 0;
  }

  List<String> list(int code) {
    List<String> res = [];
    for (int i = 0; i < items.length; i++) {
      if (code & pow(2, i).toInt() != 0) {
        res.add(items[i]);
      }
    }
    return res;
  }
}
