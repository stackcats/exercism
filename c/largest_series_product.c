#include "largest_series_product.h"

#include <ctype.h>
#include <stddef.h>
#include <stdint.h>
#include <string.h>

#define D(c) ((c) - '0')

int64_t series_product(char *num, size_t start, size_t end);

int64_t largest_series_product(char *digits, size_t size) {
  int64_t res = -1;
  size_t len = strlen(digits);
  for (size_t i = 0; i < len - size + 1; i++) {
    int64_t p = series_product(digits, i, i + size);
    if (p == -1)
      return -1;
    if (p > res) {
      res = p;
    }
  }
  return res;
}

int64_t series_product(char *num, size_t start, size_t end) {
  int64_t res = 1;
  while (start < end) {
    if (!isdigit(num[start]))
      return -1;
    res *= D(num[start]);
    start++;
  }
  return res;
}
