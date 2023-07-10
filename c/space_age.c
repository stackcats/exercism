#include "space_age.h"

#include <math.h>

float aux(float);

float age(planet_t planet, int64_t seconds) {
  switch (planet) {
  case MERCURY:
    return aux(seconds / 31557600 / 0.2408467);
  case VENUS:
    return aux(seconds / 31557600 / 0.61519726);
  case EARTH:
    return aux(seconds / 31557600);
  case MARS:
    return aux(seconds / 31557600 / 1.8808158);
  case JUPITER:
    return aux(seconds / 31557600 / 11.862615);
  case SATURN:
    return aux(seconds / 31557600 / 29.447498);
  case URANUS:
    return aux(seconds / 31557600 / 84.016846);
  case NEPTUNE:
    return aux(seconds / 31557600 / 164.79132);
  }
  return 0;
}

float aux(float t) { return round(t * 100) / 100; }
