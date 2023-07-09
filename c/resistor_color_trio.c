#include "resistor_color_trio.h"

#include <math.h>
#include <stdint.h>

resistor_value_t color_code(resistor_band_t arr[]) {
  uint32_t value = (arr[0] * 10 + arr[1]) * pow(10, arr[2]);
  resistor_unit_t unit = OHMS;
  if (value >= 1000) {
    value /= 1000;
    unit = KILOOHMS;
  }

  return (resistor_value_t){value, unit};
}
