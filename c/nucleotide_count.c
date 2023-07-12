#include "nucleotide_count.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *count(const char *dna) {
  if (dna == NULL) {
    return NULL;
  }

  char *res = (char *)malloc(strlen(dna) + 16);

  int a = 0;
  int c = 0;
  int g = 0;
  int t = 0;

  while (*dna != '\0') {
    switch (*dna++) {
    case 'A':
      a++;
      break;
    case 'C':
      c++;
      break;
    case 'G':
      g++;
      break;
    case 'T':
      t++;
      break;
    default:
      return res;
    }
  }

  sprintf(res, "A:%d C:%d G:%d T:%d", a, c, g, t);
  return res;
}
