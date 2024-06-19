import "dart:math";

typedef Item = ({int weight, int value});

class Knapsack {
  int maxWeight;
  Knapsack({required this.maxWeight});

  int maxValue(List<Item> items) {
    final dp = List.generate(maxWeight + 1, (i) => 0);
    for (final item in items) {
      for (int i = maxWeight; i >= item.weight; i--) {
        dp[i] = max(dp[i - item.weight] + item.value, dp[i]);
      }
    }
    return dp[maxWeight];
  }
}
