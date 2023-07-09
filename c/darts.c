#include "darts.h"

#include <math.h>

uint8_t score(coordinate_t pos) {
  float dis = sqrt(pos.x * pos.x + pos.y * pos.y);
  if (dis > 10) {
    return 0;
  }
  if (dis > 5) {
    return 1;
  }
  if (dis > 1)
    return 5;
  return 10;
}
