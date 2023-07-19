#include "crypto_square.h"

#include <ctype.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>

char *ciphertext(const char *input) {
  size_t input_len = strlen(input);
  char *filtered = malloc(input_len + 1);
  memset(filtered, 0, input_len + 1);
  while (*input != '\0') {
    if (isalnum(*input)) {
      char tmp[2] = {0};
      tmp[0] = tolower(*input);
      strcat(filtered, tmp);
    }
    input++;
  }
  int len = strlen(filtered);
  int end = sqrt(len) + 1;
  int r = 0, c = sqrt(len);
  while (c <= end) {
    r = c - 1;
    if (r * c >= len) {
      break;
    }
    r = c;
    if (r * c >= len) {
      break;
    }
    c++;
  }

  char *res = malloc(len + r + 64);
  memset(res, 0, len + r + 64);
  int k = 0;
  for (int j = 0; j < c; j++) {
    for (int i = 0; i < r; i++) {
      if (i * c + j >= len) {
        res[k++] = ' ';
      } else {
        res[k++] = filtered[i * c + j];
      }
    }
    if (j < c - 1) {
      res[k++] = ' ';
    }
  }
  free(filtered);
  return res;
}
