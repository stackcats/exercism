#include "perfect_numbers.h"

#include <math.h>

kind classify_number(int n) {
  if (n <= 0)
    return ERROR;
  if (n == 1)
    return DEFICIENT_NUMBER;

  int sum = 0;
  int end = sqrt(n) + 1;
  for (int i = 2; i < end; i++) {
    if (n % i == 0) {
      if (i != n / i) {
        sum += i + n / i;
      } else {
        sum += i;
      }
    }
  }
  sum += 1;
  if (sum > n)
    return ABUNDANT_NUMBER;
  if (sum == n)
    return PERFECT_NUMBER;
  return DEFICIENT_NUMBER;
}
