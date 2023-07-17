#include "say.h"

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define SIZE (1024)

const char *dt[] = {
    "zero",    "one",     "two",       "three",    "four",
    "five",    "six",     "seven",     "eight",    "nine",
    "ten",     "eleven",  "twelve",    "thirteen", "fourteen",
    "fifteen", "sixteen", "seventeen", "eighteen", "nineteen",
};

const char *tt[] = {
    "",      "",      "twenty",  "thirty", "forty",
    "fifty", "sixty", "seventy", "eighty", "ninety",
};

char *digit(long n);
char *ten(long n);
char *helper(long n, long base, const char *d, char *fun(long n));
char *hundred(long n);
char *thousand(long n);
char *million(long n);
char *billion(long n);

int say(int64_t n, char **ans) {
  if (n < 0 || n > 999999999999)
    return -1;

  *ans = billion(n);

  return 0;
}

char *digit(long n) { return (char *)dt[n]; }

char *ten(long n) {
  int t = n / 10;
  int d = n % 10;
  char *ans = (char *)malloc(sizeof(char) * SIZE);
  memset(ans, 0, sizeof(char) * SIZE);
  if (t < 2) {
    sprintf(ans, "%s", digit(n));
  } else if (d == 0) {
    sprintf(ans, "%s", tt[t]);
  } else {
    sprintf(ans, "%s-%s", tt[t], digit(d));
  }
  return ans;
}

char *helper(long n, long base, const char *d, char *fun(long n)) {
  long l = n / base;
  long r = n % base;
  char *ans = (char *)malloc(sizeof(char) * SIZE);
  memset(ans, 0, sizeof(char) * SIZE);
  char *rs = fun(r);
  char *ls = fun(l);
  if (l == 0) {
    sprintf(ans, "%s", rs);
  } else if (r == 0) {
    sprintf(ans, "%s %s", ls, d);
  } else {
    sprintf(ans, "%s %s %s", ls, d, rs);
  }
  return ans;
}

char *hundred(long n) { return helper(n, 100, "hundred", ten); }

char *thousand(long n) { return helper(n, 1000, "thousand", hundred); }

char *million(long n) { return helper(n, 1000000, "million", thousand); }

char *billion(long n) { return helper(n, 1000000000, "billion", million); }
