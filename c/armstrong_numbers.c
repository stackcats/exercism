#include "armstrong_numbers.h"

#include <math.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>

size_t len(int candidate);

size_t len(int candidate) {
  char s[256];
  sprintf(s, "%d", candidate);
  return strlen(s);
}

bool is_armstrong_number(int candidate) {
  size_t l = len(candidate);
  int sum = 0;
  int curr = candidate;
  while (curr > 0) {
    int d = curr % 10;
    sum += pow(d, l);
    if (sum > candidate)
      return false;
    curr /= 10;
  }
  return sum == candidate;
}
