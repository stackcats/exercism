#ifndef SADDLE_POINTS_H
#define SADDLE_POINTS_H

#include <stddef.h>
#include <stdint.h>

typedef struct {
  size_t row;
  size_t column;
} saddle_point_t;

typedef struct {
  size_t count;
  saddle_point_t *points;
} saddle_points_t;

saddle_points_t *saddle_points(size_t row, size_t col,
                               uint8_t matrix[row][col]);
void free_saddle_points(saddle_points_t *sp);

#endif
