#include "pythagorean_triplet.h"

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

triplets_t *triplets_with_sum(uint16_t sum) {
  triplets_t *t = malloc(sizeof(triplets_t));
  if (t == NULL) {
    return NULL;
  }

  t->triplets = malloc(sizeof(triplet_t) * 256);
  t->count = 0;
  for (uint16_t i = 1; i < sum; i++) {
    for (uint16_t j = i + 1; j < sum - i; j++) {
      uint16_t k = sum - i - j;
      if (k > sum) {
        break;
      }
      if (i * i + j * j == k * k) {
        t->triplets[t->count++] = (triplet_t){i, j, k};
      }
    }
  }

  return t;
}

void free_triplets(triplets_t *t) {
  free(t->triplets);
  free(t);
  t = NULL;
}
