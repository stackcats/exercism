#include "rotational_cipher.h"
#include <ctype.h>
#include <stdlib.h>
#include <string.h>

char *rotate(const char *text, int shift_key) {
  size_t len = strlen(text);
  char *t = malloc(len + 1);
  memset(t, 0, len + 1);

  for (size_t i = 0; text[i] != '\0'; i++) {
    if (!isalpha(text[i])) {
      t[i] = text[i];
      continue;
    }
    char start = islower(text[i]) ? 'a' : 'A';
    int offset = (text[i] - start + shift_key) % 26;
    t[i] = start + offset;
  }
  return t;
}
