#include "pig_latin.h"

#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LENGTH(x) ((int)(sizeof(x) / sizeof(x[0])))

const char *vowel[] = {"a", "e", "i", "u", "o", "yt", "xr"};

const char *co[] = {
    "thr", "sch", "ch", "qu", "th", "yt", "xr", "rh",
};

char *translate_line(const char *phrase);

char *translate(const char *phrase) {
  size_t size = strlen(phrase) + 1;
  char *tmp = (char *)malloc(size * sizeof(char));
  strcpy(tmp, phrase);

  char *res = (char *)malloc(size * sizeof(char) + 16);
  char *p = strtok(tmp, " ");
  bool flag = true;
  while (p != NULL) {
    char *word = translate_line(p);
    if (flag) {
      flag = false;
      sprintf(res, "%s", word);
    } else {
      strcat(res, " ");
      strcat(res, word);
    }
    free(word);
    p = strtok(NULL, " ");
  }

  return res;
}

char *translate_line(const char *phrase) {
  if (phrase == NULL)
    return NULL;
  size_t len = strlen(phrase) + 1 + 2;

  char *res = (char *)malloc(sizeof(char) * len);
  memset(res, 0, sizeof(char) * len);

  for (int i = 0; i < LENGTH(vowel); i++) {
    int len = strlen(vowel[i]);
    if (!strncmp(phrase, vowel[i], len)) {
      sprintf(res, "%say", phrase);
      return res;
    }
  }

  for (int i = 0; i < LENGTH(co); i++) {
    int len = strlen(co[i]);
    if (!strncmp(phrase, co[i], len)) {
      sprintf(res, "%s%say", phrase + len, co[i]);
      return res;
    }
  }

  if (!strncmp(phrase + 1, "qu", 2)) {
    sprintf(res, "%s%cquay", phrase + 3, phrase[0]);
    return res;
  }

  sprintf(res, "%s%cay", phrase + 1, phrase[0]);
  return res;
}

int main() {
  const char *phrase = "quick fast run";
  char *res = translate(phrase);
  puts(res);
  return 0;
}
