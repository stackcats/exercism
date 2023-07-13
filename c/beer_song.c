#include "beer_song.h"

#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

void recite(uint8_t start_bottles, uint8_t take_down, char **s) {
  size_t i = 0;
  while (take_down-- > 0) {
    if (start_bottles == 0) {
      sprintf(s[i++],
              "No more bottles of beer on the wall, no more bottles of beer.");
      sprintf(
          s[i++],
          "Go to the store and buy some more, 99 bottles of beer on the wall.");
    } else if (start_bottles == 1) {
      sprintf(s[i++], "%d bottle of beer on the wall, %d bottle of beer.",
              start_bottles, start_bottles);
      sprintf(s[i++], "Take it down and pass "
                      "it around, no more bottles of beer on the wall.");
    } else if (start_bottles == 2) {
      sprintf(s[i++], "%d bottles of beer on the wall, %d bottles of beer.",
              start_bottles, start_bottles);
      sprintf(s[i++],
              "Take one down and "
              "pass it around, %d bottle of beer on the wall.",
              start_bottles - 1);
    } else {
      sprintf(s[i++], "%d bottles of beer on the wall, %d bottles of beer.",
              start_bottles, start_bottles);
      sprintf(s[i++],
              "Take one down and "
              "pass it around, %d bottles of beer on the wall.",
              start_bottles - 1);
    }
    if (start_bottles > 0) {
      strcpy(s[i++], "");
    }
    start_bottles--;
  }
}
