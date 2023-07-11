#include "pangram.h"

#include <ctype.h>
#include <stdio.h>

#define SIZE 26

bool is_pangram(const char *sentence) {
  if (sentence == NULL)
    return false;

  int alpha[SIZE] = {0};

  for (int i = 0; sentence[i] != '\0'; i++) {
    if (!isalpha(sentence[i])) {
      continue;
    }
    char ch = tolower(sentence[i]);
    alpha[ch - 'a']++;
  }
  for (int i = 0; i < SIZE; i++) {
    if (alpha[i] == 0) {
      return false;
    }
  }
  return true;
}
