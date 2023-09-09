import 'dart:math';

class HighScores {
  final List<int> scores;
  List<int> sorted;

  HighScores(List<int> scores)
      : scores = scores,
        sorted = [] {
    sorted = [...scores];
    sorted.sort((a, b) => b.compareTo(a));
  }

  int latest() {
    return scores.last;
  }

  int personalBest() {
    return sorted[0];
  }

  List<int> personalTopThree() {
    return sorted.sublist(0, min(3, sorted.length));
  }
}
