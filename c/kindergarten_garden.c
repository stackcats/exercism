#include "kindergarten_garden.h"
#include <stddef.h>
#include <string.h>

size_t index(const char *student);
plant_t from_char(char c);

plants_t plants(const char *diagram, const char *student) {
  const size_t row1 = 0;
  const size_t row2 = strlen(diagram) / 2 + 1;
  size_t i = index(student);
  return (plants_t){{
      from_char(diagram[row1 + i * 2]),
      from_char(diagram[row1 + i * 2 + 1]),
      from_char(diagram[row2 + i * 2]),
      from_char(diagram[row2 + i * 2 + 1]),
  }};
}

size_t index(const char *student) {
  const char *student_names[] = {
      "Alice", "Bob",     "Charlie", "David",  "Eve",     "Fred",
      "Ginny", "Harriet", "Ileana",  "Joseph", "Kincaid", "Larry",
  };

  const size_t len = sizeof(student_names) / sizeof(*student_names);

  for (size_t i = 0; i < len; i++) {
    if (!strcmp(student_names[i], student)) {
      return i;
    }
  }

  return 0;
}

plant_t from_char(char c) {
  switch (c) {
  case 'C':
    return CLOVER;
  case 'G':
    return GRASS;
  case 'R':
    return RADISHES;
  case 'V':
    return VIOLETS;
  default:
    return CLOVER;
  }
}
