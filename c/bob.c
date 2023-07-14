#include "bob.h"

#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *hey_bob(char *greeting) {
  int start = 0;
  while (greeting[start] != '\0' && isspace(greeting[start])) {
    start++;
  }

  int end = strlen(greeting) - 1;
  while (end > start && isspace(greeting[end])) {
    end--;
  }

  char *buff = malloc(64);
  if (end <= start) {
    sprintf(buff, "Fine. Be that way!");
    return buff;
  }

  bool flag = true;
  bool only_number = true;
  for (int i = start; i <= end; i++) {
    if (!isalpha(greeting[i])) {
      continue;
    }
    only_number = false;
    if (islower(greeting[i])) {
      flag = false;
      break;
    }
  }

  if (only_number) {
    flag = false;
  }

  if (flag && greeting[end] == '?') {
    sprintf(buff, "Calm down, I know what I'm doing!");
    return buff;
  }

  if (flag) {
    sprintf(buff, "Whoa, chill out!");
    return buff;
  }

  if (greeting[end] == '?') {
    sprintf(buff, "Sure.");
    return buff;
  }

  sprintf(buff, "Whatever.");
  return buff;
}
