#include "resistor_color.h"
#include <stdint.h>
#include <stdlib.h>

uint16_t color_code(resistor_band_t rb) { return rb; }

resistor_band_t *colors() {
  resistor_band_t *res = malloc(sizeof(resistor_band_t) * 10);
  for (uint16_t i = 0; i < 10; i++) {
    res[i] = i;
  }
  return res;
}
