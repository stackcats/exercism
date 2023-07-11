#include "rail_fence_cipher.h"

#include <ctype.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

char *encode(char *text, size_t rails) {
  size_t text_len = strlen(text);
  char mat[rails][text_len];
  memset(mat, 0, rails * text_len);
  int row = 0, dx = 1, col = 0;
  for (size_t i = 0; i < text_len; i++) {
    mat[row][col] = text[i];
    if (row + dx == -1) {
      dx = 1;
      col += 1;
    } else if (row + dx == (int)rails) {
      dx = -1;
      col += 1;
    }
    row += dx;
  }

  char *encoded = malloc(strlen(text) + 1);
  char *p = encoded;
  for (size_t i = 0; i < rails; i++) {
    for (size_t j = 0; j < text_len; j++) {
      if (isalnum(mat[i][j])) {
        *p++ = mat[i][j];
      }
    }
  }
  *p = '\0';
  return encoded;
}

char *decode(char *ciphertext, size_t rails) {
  char *decoded = malloc(strlen(ciphertext) + 1);
  char *s = malloc(strlen(ciphertext) + 1);
  strcpy(s, ciphertext);
  while (1) {
    strcpy(decoded, s);
    char *t = encode(s, rails);
    if (!strcmp(t, ciphertext)) {
      break;
    }
    strcpy(s, t);
    free(t);
  }
  return decoded;
}
