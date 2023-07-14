#include "roman_numerals.h"

#include <stdlib.h>
#include <string.h>

#define SIZE (1024)

char *to_roman_numeral(unsigned int n) {
  char *res = (char *)malloc(sizeof(char) * SIZE);
  memset(res, 0, sizeof(char) * SIZE);
  int x = n / 1000;
  if (x == 3) {
    strcat(res, "MMM");
  } else if (x == 2) {
    strcat(res, "MM");
  } else if (x == 1) {
    strcat(res, "M");
  }
  n %= 1000;
  x = n / 100;
  if (x == 9) {
    strcat(res, "CM");
  } else if (x == 8) {
    strcat(res, "DCCC");
  } else if (x == 7) {
    strcat(res, "DCC");
  } else if (x == 6) {
    strcat(res, "DC");
  } else if (x == 5) {
    strcat(res, "D");
  } else if (x == 4) {
    strcat(res, "CD");
  } else if (x == 3) {
    strcat(res, "CCC");
  } else if (x == 2) {
    strcat(res, "CC");
  } else if (x == 1) {
    strcat(res, "C");
  }
  n %= 100;
  x = n / 10;
  if (x == 9) {
    strcat(res, "XC");
  } else if (x == 8) {
    strcat(res, "LXXX");
  } else if (x == 7) {
    strcat(res, "LXX");
  } else if (x == 6) {
    strcat(res, "LX");
  } else if (x == 5) {
    strcat(res, "L");
  } else if (x == 4) {
    strcat(res, "XL");
  } else if (x == 3) {
    strcat(res, "XXX");
  } else if (x == 2) {
    strcat(res, "XX");
  } else if (x == 1) {
    strcat(res, "X");
  }
  x = n % 10;
  if (x == 9) {
    strcat(res, "IX");
  } else if (x == 8) {
    strcat(res, "VIII");
  } else if (x == 7) {
    strcat(res, "VII");
  } else if (x == 6) {
    strcat(res, "VI");
  } else if (x == 5) {
    strcat(res, "V");
  } else if (x == 4) {
    strcat(res, "IV");
  } else if (x == 3) {
    strcat(res, "III");
  } else if (x == 2) {
    strcat(res, "II");
  } else if (x == 1) {
    strcat(res, "I");
  }
  return res;
}
