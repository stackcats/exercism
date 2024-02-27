#include "spiral_matrix.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

spiral_matrix_t *spiral_matrix_create(int size) {
  spiral_matrix_t *sp = calloc(1, sizeof(spiral_matrix_t));
  sp->size = size;
  if (size == 0) {
    return sp;
  }

  sp->matrix = calloc(size, sizeof(int *));
  for (int i = 0; i < size; i++) {
    sp->matrix[i] = calloc(size, sizeof(int));
    memset(sp->matrix[i], 0, sizeof(int) * size);
  }

  int x = 0;
  int y = 0;
  int dx = 0;
  int dy = 1;
  for (int i = 1; i <= size * size; i++) {
    sp->matrix[x][y] = i;
    int nx = x + dx;
    int ny = y + dy;
    if (nx < 0 || nx >= size || ny < 0 || ny >= size ||
        sp->matrix[nx][ny] > 0) {
      int t = -dx;
      dx = dy;
      dy = t;
    }
    x += dx;
    y += dy;
  }

  return sp;
}

void spiral_matrix_destroy(spiral_matrix_t *sp) {
  for (int i = 0; i < sp->size; i++) {
    free(sp->matrix[i]);
  }

  free(sp->matrix);

  free(sp);
}
