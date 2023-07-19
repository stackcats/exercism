#include "nth_prime.h"

#include <math.h>
#include <stdbool.h>

bool is_prime(uint32_t n);

uint32_t nth(uint32_t n) {
  if (n < 1)
    return 0;
  uint32_t i = 1;
  uint32_t res = 2;
  while (true) {
    if (is_prime(res)) {
      if (i == n)
        return res;
      i++;
    }
    res++;
  }
}

bool is_prime(uint32_t n) {
  if (n < 2)
    return false;
  if (n == 2)
    return true;
  uint32_t end = (uint32_t)sqrt(n) + 1;
  uint32_t i = 2;
  while (i < end) {
    if (n % i == 0)
      return false;
    i++;
  }
  return true;
}
