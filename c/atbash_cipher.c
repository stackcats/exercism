#include "atbash_cipher.h"

#include <ctype.h>
#include <stdlib.h>
#include <string.h>

const char *plain = "abcdefghijklmnopqrstuvwxyz";
const char *cipher = "zyxwvutsrqponmlkjihgfedcba";

char *atbash_encode(const char *input) {
  size_t len = strlen(input);
  len += len / 5;
  char *res = (char *)malloc(sizeof(char) * len);
  memset(res, 0, sizeof(char) * len + 1);
  int i = 0;
  int size = 0;

  while (*input != '\0') {
    char c = tolower(*input++);
    if (!isalnum(c)) {
      continue;
    }

    if (size == 5) {
      res[i++] = ' ';
      size = 0;
    }
    if (isalpha(c)) {
      int pos = c - 'a';
      res[i++] = cipher[pos];
    } else {
      res[i++] = c;
    }

    size++;
  }

  return res;
}

char *atbash_decode(const char *input) {
  size_t len = strlen(input) + 1;
  char *res = (char *)malloc(sizeof(char) * len);
  memset(res, 0, sizeof(char) * len);
  int i = 0;
  while (*input != '\0') {
    char c = *input++;
    if (isspace(c)) {
      continue;
    }
    if (isdigit(c)) {
      res[i++] = c;
    } else {
      int pos = 'z' - c;
      res[i++] = plain[pos];
    }
  }

  return res;
}
