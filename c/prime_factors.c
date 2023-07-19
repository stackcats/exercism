#include "prime_factors.h"

size_t find_factors(uint64_t n, uint64_t buf[static MAXFACTORS]) {
  size_t i = 0;
  uint64_t x = 2;
  while (n >= x) {
    if (n % x == 0) {
      n /= x;
      buf[i++] = x;
    } else {
      x++;
    }
  }

  return i;
}
