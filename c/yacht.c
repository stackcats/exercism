#include "yacht.h"
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

static bool findCount(int counter[5], int ct) {
  for (int i = 0; i < 5; i++) {
    if (counter[i] == ct) {
      return true;
    }
  }
  return false;
}

static int cmp(const void *a, const void *b) {
  int int_a = *((int *)a);
  int int_b = *((int *)b);

  if (int_a == int_b)
    return 0;
  if (int_a < int_b)
    return -1;
  return 1;
}

int score(dice_t dice, category_t category) {
  qsort(dice.faces, 5, sizeof(int), cmp);

  int counter[6] = {0};
  int sum = 0;
  for (int i = 0; i < 5; i++) {
    counter[dice.faces[i] - 1]++;
    sum += dice.faces[i];
  }

  if (category == YACHT) {
    if (findCount(counter, 5)) {
      return 50;
    }
  }

  if (category < FULL_HOUSE) {
    return counter[category] * (category + 1);
  }

  if (category == FULL_HOUSE) {
    if (findCount(counter, 3) && findCount(counter, 2)) {
      return sum;
    }
  }

  if (category == FOUR_OF_A_KIND) {
    for (int i = 0; i < 6; i++) {
      if (counter[i] >= 4) {
        return (i + 1) * 4;
      }
    }
  }

  if (category == LITTLE_STRAIGHT) {
    int tmp[5] = {1, 2, 3, 4, 5};
    if (!memcmp(&dice.faces, &tmp, sizeof(int) * 5)) {
      return 30;
    }
  }

  if (category == BIG_STRAIGHT) {
    int tmp[5] = {2, 3, 4, 5, 6};
    if (!memcmp(&dice.faces, &tmp, sizeof(int) * 5)) {
      return 30;
    }
  }

  if (category == CHOICE) {
    return sum;
  }
  return 0;
}
