import 'package:binary_search/value_not_found_exception.dart';

class BinarySearch {
  final List<int> arr;

  BinarySearch(this.arr);

  int find(int target) {
    int lft = 0;
    int rht = arr.length - 1;
    while (lft <= rht) {
      final m = lft + (rht - lft) ~/ 2;
      if (arr[m] == target) {
        return m;
      }
      if (arr[m] < target) {
        lft = m + 1;
      } else {
        rht = m - 1;
      }
    }
    throw ValueNotFoundException('not found');
  }
}
