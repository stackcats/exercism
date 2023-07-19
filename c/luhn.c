#include "luhn.h"

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *trim(const char *s);

bool luhn(const char *n) {
  char *num = trim(n);
  size_t len = strlen(num);
  if (len <= 1)
    return false;
  int sum = 0;
  int pos = 1;
  for (int i = (int)len - 1; i >= 0; i--) {
    if (isspace(num[i]))
      continue;
    if (!isdigit(num[i]))
      return false;
    int n = num[i] - '0';
    if (pos % 2 == 0) {
      n *= 2;
      if (n > 9)
        n -= 9;
    }
    sum += n;
    pos++;
  }
  free(num);
  return sum % 10 == 0;
}

char *trim(const char *s) {
  char *p = (char *)s;
  while (*p != '\0' && isspace(*p)) {
    p++;
  }

  size_t len = strlen(s);
  char *q = (char *)s + len - 1;
  while (q > p && isspace(*q)) {
    q--;
  }
  char *res = (char *)malloc((len + 1) * sizeof(char));
  memset(res, 0, (len + 1) * sizeof(char));
  strncpy(res, p, q - p + 1);
  return res;
}
