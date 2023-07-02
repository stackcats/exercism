#include "hamming.h"
#include <stddef.h>

int compute(const char *a, const char *b) {
  if (a == NULL || b == NULL)
    return -1;
  int diff = 0;
  while (*a != '\0' && *b != '\0') {
    if (*a++ != *b++) {
      diff++;
    }
  }
  if (*a != '\0' || *b != '\0')
    return -1;
  return diff;
}
