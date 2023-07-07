#include "clock.h"

#include <stdio.h>
#include <string.h>

clock_t clock_create(int hour, int minute) {
  clock_t t;

  while (minute < 0) {
    minute += 60;
    hour -= 1;
  }

  while (hour < 0) {
    hour += 24;
  }
  sprintf(t.text, "%02d:%02d", (hour + minute / 60) % 24, minute % 60);
  return t;
}

clock_t clock_add(clock_t clock, int minute_add) {
  int hour, minute;
  sscanf(clock.text, "%d:%d", &hour, &minute);
  minute += minute_add;
  return clock_create(hour, minute);
}

clock_t clock_subtract(clock_t clock, int minute_subtract) {
  int hour, minute;
  sscanf(clock.text, "%d:%d", &hour, &minute);
  minute -= minute_subtract;
  return clock_create(hour, minute);
}

bool clock_is_equal(clock_t a, clock_t b) {
  return strcmp(a.text, b.text) == 0;
}
