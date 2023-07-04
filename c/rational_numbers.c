#include "rational_numbers.h"

#include <math.h>
#include <stdlib.h>

int gcd(int a, int b);

rational_t add(rational_t a, rational_t b) {
  rational_t r;
  r.numerator = a.numerator * b.denominator + b.numerator * a.denominator;
  r.denominator = a.denominator * b.denominator;
  return reduce(r);
}

rational_t subtract(rational_t a, rational_t b) {
  rational_t r;
  r.numerator = a.numerator * b.denominator - b.numerator * a.denominator;
  r.denominator = a.denominator * b.denominator;
  return reduce(r);
}

rational_t multiply(rational_t a, rational_t b) {
  rational_t r;
  r.numerator = a.numerator * b.numerator;
  r.denominator = a.denominator * b.denominator;
  return reduce(r);
}

rational_t divide(rational_t a, rational_t b) {
  rational_t r;
  r.numerator = a.numerator * b.denominator;
  r.denominator = a.denominator * b.numerator;
  return reduce(r);
}

rational_t absolute(rational_t r) {
  return reduce((rational_t){.denominator = abs(r.denominator),
                             .numerator = abs(r.numerator)});
}

rational_t exp_rational(rational_t a, int16_t n) {
  int d = n < 0 ? a.numerator : a.denominator;
  int nu = n < 0 ? a.denominator : a.numerator;
  n = abs(n);
  rational_t r =
      (rational_t){.denominator = pow(d, n), .numerator = pow(nu, n)};
  return reduce(r);
}

float exp_real(uint16_t x, rational_t r) {
  return pow(pow(x, r.numerator), 1. / r.denominator);
}

rational_t reduce(rational_t r) {
  if (r.numerator == 0) {
    return (rational_t){.denominator = 1, .numerator = 0};
  }
  int d = abs(r.denominator);
  int n = abs(r.numerator);
  int g = gcd(d, n);
  int sign = r.denominator * r.numerator < 0 ? -1 : 1;
  return (rational_t){.denominator = d / g, .numerator = n * sign / g};
}

int gcd(int a, int b) {
  if (a % b == 0)
    return b;

  return gcd(b, a % b);
}
