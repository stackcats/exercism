import 'dart:math';

class NthPrime {
  int prime(int n) {
    if (n == 0) {
      throw ArgumentError('There is no zeroth prime');
    }

    int p = 1;
    while (n > 0) {
      if (isPrime(++p)) {
        n--;
      }
    }
    return p;
  }

  bool isPrime(int n) {
    if (n < 2) {
      return false;
    }

    if (n == 2) {
      return true;
    }

    for (int i = 2; i < sqrt(n).ceil() + 1; i++) {
      if (n % i == 0) {
        return false;
      }
    }
    return true;
  }
}
