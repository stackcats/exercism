import 'dart:collection';
import 'dart:math';

typedef Result = ({int moves, String goalBucket, int otherBucket});

class TwoBucket {
  final int bucketOne;
  final int bucketTwo;
  final int goal;
  final String startBucket;

  TwoBucket({
    required this.bucketOne,
    required this.bucketTwo,
    required this.goal,
    required this.startBucket,
  });

  Result measure() {
    final seen = <(int, int)>{};
    final q = Queue<(int, int, int)>();
    if (startBucket == "one") {
      q.add((bucketOne, 0, 1));
    } else {
      q.add((0, bucketTwo, 1));
    }

    while (q.isNotEmpty) {
      final (b1, b2, ct) = q.removeFirst();
      if (b1 == goal) {
        return (moves: ct, goalBucket: "one", otherBucket: b2);
      }

      if (b2 == goal) {
        return (moves: ct, goalBucket: "two", otherBucket: b1);
      }

      if (startBucket == "one") {
        if ((b1, b2) == (0, bucketTwo)) {
          continue;
        }
      } else {
        if ((b1, b2) == (bucketOne, 0)) {
          continue;
        }
      }

      if (seen.contains((b1, b2))) {
        continue;
      }

      seen.add((b1, b2));

      int p = min(bucketTwo - b2, b1);
      q.addLast((b1 - p, b2 + p, ct + 1));
      q.addLast((0, b2, ct + 1));
      q.addLast((bucketOne, b2, ct + 1));

      p = min(bucketOne - b1, b2);
      q.addLast((b1 + p, b2 - p, ct + 1));
      q.addLast((b1, 0, ct + 1));
      q.addLast((b1, bucketTwo, ct + 1));
    }

    throw ArgumentError("impossible");
  }
}
