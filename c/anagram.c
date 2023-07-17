#include "anagram.h"

#include <ctype.h>
#include <stdlib.h>
#include <string.h>

void copy(char *desc, const char *src);
int equal(const char *s1, const char *s2);
int cmp(const void *a, const void *b);

void find_anagrams(const char *subject, struct candidates *candidates) {
  char tmp[MAX_STR_LEN];
  copy(tmp, subject);
  qsort(tmp, strlen(tmp), sizeof(char), cmp);
  for (int i = 0; i < (int)candidates->count; i++) {
    if (equal(subject, candidates->candidate[i].word)) {
      candidates->candidate[i].is_anagram = NOT_ANAGRAM;
      continue;
    }
    char x[MAX_STR_LEN];
    copy(x, candidates->candidate[i].word);
    qsort(x, strlen(x), sizeof(char), cmp);
    if (equal(tmp, x)) {
      candidates->candidate[i].is_anagram = IS_ANAGRAM;
    } else {
      candidates->candidate[i].is_anagram = NOT_ANAGRAM;
    }
  }
}

void copy(char *desc, const char *src) {
  while ((*desc++ = tolower(*src++)) != '\0')
    ;
  *desc = '\0';
}

int equal(const char *s1, const char *s2) {
  while (*s1 != '\0' && *s2 != '\0' && tolower(*s1) == tolower(*s2)) {
    s1++;
    s2++;
  }
  if (*s1 != '\0')
    return 0;
  if (*s2 != '\0')
    return 0;
  return 1;
}

int cmp(const void *a, const void *b) { return *(char *)a - *(char *)b; }
