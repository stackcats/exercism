#include "difference_of_squares.h"

unsigned int sum_of_squares(unsigned int n) {
  return n * (n + 1) * (2 * n + 1) / 6;
}

unsigned int square_of_sum(unsigned int n) {
  unsigned int sum = (1 + n) * n / 2;
  return sum * sum;
}

unsigned int difference_of_squares(unsigned int number) {
  return square_of_sum(number) - sum_of_squares(number);
}
