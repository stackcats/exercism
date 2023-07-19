#include "scrabble_score.h"

#include <ctype.h>

unsigned int score(const char *word) {
  int res = 0;

  while (*word != '\0') {
    int sc = 1;
    switch (tolower(*word)) {
    case 'd':
    case 'g':
      sc = 2;
      break;
    case 'b':
    case 'c':
    case 'm':
    case 'p':
      sc = 3;
      break;
    case 'f':
    case 'h':
    case 'v':
    case 'w':
    case 'y':
      sc = 4;
      break;
    case 'k':
      sc = 5;
      break;
    case 'j':
    case 'x':
      sc = 8;
      break;
    case 'q':
    case 'z':
      sc = 10;
      break;
    }
    res += sc;
    word++;
  }
  return res;
}
