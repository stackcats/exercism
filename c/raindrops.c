#include "raindrops.h"

#include <stdio.h>
#include <string.h>

char *convert(char res[], int drops) {
  if (drops % 3 == 0) {
    strcat(res, "Pling");
  }
  if (drops % 5 == 0) {
    strcat(res, "Plang");
  }
  if (drops % 7 == 0) {
    strcat(res, "Plong");
  }
  if (strlen(res) == 0) {
    sprintf(res, "%d", drops);
  }

  return res;
}
