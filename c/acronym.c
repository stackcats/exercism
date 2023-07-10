#include "acronym.h"

#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define SIZE 1024

char *abbreviate(const char *phrase) {
  if (phrase == NULL) {
    return NULL;
  }

  char *abbr = malloc(SIZE);
  if (abbr == NULL) {
    return NULL;
  }

  memset(abbr, 0, SIZE);

  bool flag = false;
  for (int i = 0; phrase[i] != '\0'; i++) {
    if (phrase[i] == ' ' || phrase[i] == '-' || phrase[i] == '_') {
      flag = true;
      continue;
    }
    if (i == 0 || flag == true) {
      flag = false;
      sprintf(abbr + strlen(abbr), "%c", toupper(phrase[i]));
    }
  }
  return !strcmp(abbr, "") ? NULL : abbr;
}
