#include "sieve.h"

#include <stdint.h>
#include <stdlib.h>
#include <string.h>

uint32_t sieve(uint32_t limit, uint32_t *primes, size_t max_primes) {
  uint32_t *tmp = malloc(sizeof(uint32_t) * max_primes);
  if (tmp == NULL) {
    return 0;
  }
  memset(tmp, 0, sizeof(uint32_t) * max_primes);

  for (uint32_t i = 2; i <= limit; i++) {
    if (tmp[i] == 0) {
      uint32_t k = i + i;
      while (k <= limit) {
        tmp[k] = 1;
        k += i;
      }
    }
  }

  uint32_t ndx = 0;
  for (uint32_t i = 2; i <= limit; i++) {
    if (tmp[i] == 0) {
      primes[ndx++] = i;
      if (ndx >= max_primes) {
        break;
      }
    }
  }

  return ndx;
}
