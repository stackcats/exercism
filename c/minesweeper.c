#include "minesweeper.h"

#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

bool is_valid(size_t x, size_t y, size_t row, size_t col);
char count(const char **grid, size_t x, size_t y, size_t row, size_t col);

char **annotate(const char **grid, size_t row) {
  if (grid == NULL || row <= 0)
    return NULL;
  char **res = (char **)malloc(sizeof(char *) * (row + 1));
  memset(res, 0, sizeof(char *) * (row + 1));

  size_t col = strlen(grid[0]);
  for (size_t i = 0; i < row; i++) {
    res[i] = (char *)malloc(sizeof(char) * (col + 1));
    memset(res[i], 0, sizeof(char) * (col + 1));
  }
  for (size_t i = 0; i < row; i++) {
    for (size_t j = 0; j < col; j++) {
      if (grid[i][j] == '*') {
        res[i][j] = '*';
      } else {
        res[i][j] = count(grid, i, j, row, col);
      }
    }
  }
  return res;
}

void free_annotation(char **annotate) {
  char **p = annotate;
  while (*p != NULL) {
    char *tmp = *p;
    p++;
    free(tmp);
  }
  free(annotate);
}

bool is_valid(size_t x, size_t y, size_t row, size_t col) {
  return x < row && y < col;
}

char count(const char **grid, size_t x, size_t y, size_t row, size_t col) {
  int arr[][2] = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1},
                  {0, 1},   {1, -1}, {1, 0},  {1, 1}};
  int ct = 0;
  for (int i = 0; i < 8; i++) {
    size_t nx = x + arr[i][0];
    size_t ny = y + arr[i][1];
    if (is_valid(nx, ny, row, col) && grid[nx][ny] == '*') {
      ct++;
    }
  }
  return ct > 0 ? ct + '0' : ' ';
}
