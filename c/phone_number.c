#include "phone_number.h"

#include <ctype.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool is_valid(char c);
bool is_n(char c);
bool is_x(char c);

char *phone_number_clean(const char *input) {
  char *res = (char *)malloc(16 * sizeof(char));
  if (res == NULL)
    return NULL;

  char *q = res;
  for (const char *p = input; *p != '\0'; p++) {
    if (!is_valid(*p)) {
      goto ERR;
    }
    if (isdigit(*p)) {
      *q++ = *p;
    }
  }
  *q = '\0';

  size_t rlen = strlen(res);
  if (rlen == 11 && res[0] == '1') {
    memmove(res, res + 1, rlen);
    rlen--;
  }

  if (rlen != 10) {
    goto ERR;
  }

  for (size_t i = 0; i < rlen; i++) {
    if (i == 0 || i == 3) {
      if (!is_n(res[i])) {
        goto ERR;
      }
    } else {
      if (!is_x(res[i])) {
        goto ERR;
      }
    }
  }

  return res;

ERR:
  sprintf(res, "%s", "0000000000");
  return res;
}

bool is_valid(char c) {
  return isdigit(c) || c == ' ' || c == '(' || c == ')' || c == '-' ||
         c == '.' || c == '+';
}

bool is_n(char c) { return c >= '2' && c <= '9'; }

bool is_x(char c) { return c >= '0' && c <= '9'; }
