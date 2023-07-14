#include "sum_of_multiples.h"

unsigned int sum(const unsigned int *factors, const size_t number_of_factors,
                 const unsigned int limit) {
  if (factors == NULL)
    return 0;
  if (number_of_factors == 0)
    return 0;

  unsigned long res = 0;
  unsigned int start = factors[0];
  while (start < limit) {
    for (size_t i = 0; i < number_of_factors; i++) {
      if (factors[i] != 0 && start % factors[i] == 0) {
        res += start;
        break;
      }
    }
    start++;
  }
  return res;
}
