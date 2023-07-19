#include "all_your_base.h"

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

size_t rebase(int8_t digits[], int16_t input_base, int16_t output_base,
              size_t input_length) {
  if (input_base <= 1 || output_base <= 1) {
    digits[0] = 0;
    return 0;
  }

  int16_t num = 0;
  for (size_t i = 0; i < input_length; i++) {
    if (digits[i] >= input_base || digits[i] < 0) {
      digits[0] = 0;
      return 0;
    }
    num = num * input_base + digits[i];
  }

  size_t len = 0;
  while (num > 0) {
    digits[len++] = num % output_base;
    num /= output_base;
  }

  for (int i = 0, j = len - 1; i <= j; i++, j--) {
    int8_t t = digits[i];
    digits[i] = digits[j];
    digits[j] = t;
  }

  return len;
}
