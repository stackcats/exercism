class DifferenceOfSquares {
  int squareOfSum(int n) {
    int sum = List.generate(n, (i) => i + 1).reduce((a, b) => a + b);
    return sum * sum;
  }

  int sumOfSquares(int n) {
    return List.generate(n, (i) => (i + 1) * (i + 1)).reduce((a, b) => a + b);
  }

  int differenceOfSquares(int n) {
    return squareOfSum(n) - sumOfSquares(n);
  }
}
