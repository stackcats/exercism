#include "reverse_string.h"

#include <stddef.h>
#include <stdlib.h>
#include <string.h>

char *reverse(const char *value) {
  size_t len = strlen(value);
  char *s = malloc(sizeof(char) * (len + 1));
  for (size_t i = 0; i < len; i++) {
    s[i] = value[len - i - 1];
  }
  s[len] = '\0';
  return s;
}
