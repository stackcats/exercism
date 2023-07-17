#ifndef MINESWEEPER_H
#define MINESWEEPER_H

#include <stddef.h>

char **annotate(const char **, size_t);
void free_annotation(char **);

#endif
