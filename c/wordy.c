#include "wordy.h"

#include <stdio.h>

bool answer(const char *question, int *result) {
  int offset = 0;

  if (!sscanf(question, "What is %d%n", result, &offset)) {
    return false;
  }

  question += offset + 1;

  int n = 0;
  while (*question) {
    if (sscanf(question, "plus %d%n", &n, &offset)) {
      *result += n;
    } else if (sscanf(question, "minus %d%n", &n, &offset)) {
      *result -= n;
    } else if (sscanf(question, "multiplied by %d%n", &n, &offset)) {
      *result *= n;
    } else if (sscanf(question, "divided by %d%n", &n, &offset)) {
      *result /= n;
    } else {
      return false;
    }
    question += offset + 1;
  }

  return true;
}
