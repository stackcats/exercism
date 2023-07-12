#include "secret_handshake.h"

#include <stddef.h>
#include <stdlib.h>

#define WINK (1)
#define DOUBLE_BLINK (2)
#define CLOSE_YOURE_EYES (4)
#define JUMP (8)
#define REVERSE (16)
#define SIZE (4)

const char *wink = "wink";
const char *double_blink = "double blink";
const char *close_your_eyes = "close your eyes";
const char *jump = "jump";

const char **commands(size_t n) {
  const char **res = (const char **)malloc(sizeof(const char *) * SIZE);
  int i = 0;
  if (REVERSE & n) {
    if (JUMP & n) {
      res[i++] = jump;
    }
    if (CLOSE_YOURE_EYES & n) {
      res[i++] = close_your_eyes;
    }
    if (DOUBLE_BLINK & n) {
      res[i++] = double_blink;
    }
    if (WINK & n) {
      res[i++] = wink;
    }
  } else {
    if (WINK & n) {
      res[i++] = wink;
    }
    if (DOUBLE_BLINK & n) {
      res[i++] = double_blink;
    }
    if (CLOSE_YOURE_EYES & n) {
      res[i++] = close_your_eyes;
    }
    if (JUMP & n) {
      res[i++] = jump;
    }
  }
  if (i == 0) {
    res[i] = NULL;
  }
  return res;
}
