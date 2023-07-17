#include "diamond.h"

#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **make_diamond(char letter) {
  int lines = 2 * (letter - 'A' + 1) - 1;
  char **res = (char **)malloc(sizeof(char *) * lines);
  char start = 'A';
  int dt = 1;
  int begin_spaces = letter - 'A';
  int end_spaces = -1;

  for (int i = 0; i < lines; i++) {
    res[i] = (char *)malloc(sizeof(char) * lines + sizeof(char));
    memset(res[i], 0, sizeof(char) * lines + sizeof(char));
    int idx = 0;
    if (start == letter) {
      dt = -1;
    }
    for (int j = 0; j < begin_spaces; j++) {
      res[i][idx++] = ' ';
    }
    res[i][idx++] = start;
    if (end_spaces > 0) {
      for (int j = 0; j < end_spaces; j++) {
        res[i][idx++] = ' ';
      }
      res[i][idx++] = start;
    }
    while (idx < lines) {
      res[i][idx++] = ' ';
    }

    begin_spaces -= dt;
    start += dt;
    end_spaces += 2 * dt;
  }

  return res;
}

void free_diamond(char **diamond) {
  size_t len = strlen(diamond[0]);
  for (size_t i = 0; i < len; i++) {
    free(diamond[i]);
  }
  free(diamond);
}
