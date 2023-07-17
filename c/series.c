#include "series.h"

#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

slices_t slices(char *input_text, unsigned int substring_length) {
  unsigned int ct = 0;
  if (substring_length > 0 && strlen(input_text) >= substring_length) {
    ct = strlen(input_text) - substring_length + 1;
  }
  slices_t sr;
  sr.substring_count = ct;
  sr.substring = (char **)malloc(sizeof(char *) * ct);
  size_t i = 0;
  for (size_t j = 0; j < ct; j++) {
    sr.substring[i] = (char *)malloc(1 + substring_length);
    memset(sr.substring[i], 0, 1 + substring_length);
    strncpy(sr.substring[i], input_text + j, substring_length);
    i++;
  }
  return sr;
}
