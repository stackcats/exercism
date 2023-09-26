class PrimeFactors {
  List<int> factors(int num) {
    List<int> factors = [];
    int factor = 2;
    while (num > 1) {
      if (num % factor == 0) {
        factors.add(factor);
        num ~/= factor;
      } else {
        factor++;
      }
    }
    return factors;
  }
}
