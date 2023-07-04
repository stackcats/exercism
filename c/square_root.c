#include "square_root.h"

uint16_t square_root(uint16_t n) {
  for (uint16_t i = 1; i <= n; i++) {
    if (i * i == n) {
      return i;
    }
  }
  return 0;
}
