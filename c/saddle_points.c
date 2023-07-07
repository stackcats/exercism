#include "saddle_points.h"

#include <stdbool.h>
#include <stddef.h>
#include <stdlib.h>

bool is_max_in_row(size_t i, size_t j, size_t row, size_t col,
                   uint8_t matrix[row][col]);
bool is_min_in_col(size_t i, size_t j, size_t row, size_t col,
                   uint8_t matrix[row][col]);

saddle_points_t *saddle_points(size_t row, size_t col,
                               uint8_t matrix[row][col]) {
  saddle_points_t *sp = malloc(sizeof(saddle_points_t));
  if (sp == NULL) {
    return NULL;
  }

  sp->count = 0;

  sp->points = malloc(sizeof(saddle_point_t) * row * col);
  if (sp->points == NULL) {
    return NULL;
  }

  for (size_t i = 0; i < row; i++) {
    for (size_t j = 0; j < col; j++) {
      if (is_max_in_row(i, j, row, col, matrix) &&
          is_min_in_col(i, j, row, col, matrix)) {
        sp->points[sp->count++] = (saddle_point_t){i + 1, j + 1};
      }
    }
  }

  return sp;
}

void free_saddle_points(saddle_points_t *sp) {
  free(sp->points);
  free(sp);
  sp = NULL;
}

bool is_max_in_row(size_t i, size_t j, size_t row, size_t col,
                   uint8_t matrix[row][col]) {
  for (size_t k = 0; k < col; k++) {
    if (k != j && matrix[i][k] > matrix[i][j]) {
      return false;
    }
  }

  return true;
}

bool is_min_in_col(size_t i, size_t j, size_t row, size_t col,
                   uint8_t matrix[row][col]) {
  for (size_t k = 0; k < row; k++) {
    if (k != i && matrix[k][j] < matrix[i][j]) {
      return false;
    }
  }

  return true;
}
