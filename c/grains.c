#include "grains.h"

unsigned long long square(int n) {
  if (n < 1 || n > 64)
    return 0ul;

  unsigned long long res = 1;
  int base = 2;

  n--;
  while (n > 0) {
    res *= base;
    n--;
  }
  return res;
}
unsigned long long total() {
  unsigned long long tot = 0ul;
  for (int i = 1; i <= 64; i++) {
    tot += square(i);
  }
  return tot;
}
