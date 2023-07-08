#include "pascals_triangle.h"

#include <math.h>
#include <stdlib.h>
#include <string.h>

uint8_t **create_triangle(size_t rows) {
  uint8_t **res = malloc(sizeof(size_t *) * fmax(rows, 1));
  if (res == NULL) {
    return NULL;
  }

  if (rows == 0) {
    res[0] = malloc(sizeof(uint8_t));
    res[0][0] = 0;
    return res;
  }

  for (size_t i = 0; i < rows; i++) {
    res[i] = malloc(sizeof(uint8_t) * rows);
    memset(res[i], 0, sizeof(uint8_t) * rows);
    for (size_t j = 0; j < rows; j++) {
      if (i == 0) {
        res[0][0] = 1;
      } else if (j == 0 || j == i) {
        res[i][j] = 1;
      } else if (j < i) {
        res[i][j] = res[i - 1][j - 1] + res[i - 1][j];
      } else {
        res[i][j] = 0;
      }
    }
  }

  return res;
}
void free_triangle(uint8_t **triangle, size_t rows) {
  if (triangle == NULL) {
    return;
  }

  for (size_t i = 0; i < rows; i++) {
    if (triangle[i] != NULL) {
      free(triangle[i]);
    }
  }
  free(triangle);
  triangle = NULL;
}
