#include "rna_transcription.h"

#include <stdlib.h>
#include <string.h>

char *to_rna(const char *dna) {
  if (dna == NULL) {
    return NULL;
  }

  char *rna = malloc(strlen(dna) + 1);
  char *p = rna;
  while (*dna != '\0') {
    switch (*dna++) {
    case 'G':
      *p++ = 'C';
      break;
    case 'C':
      *p++ = 'G';
      break;
    case 'T':
      *p++ = 'A';
      break;
    case 'A':
      *p++ = 'U';
      break;
    default:
      free(rna);
      return NULL;
    }
  }

  *p = '\0';
  return rna;
}
