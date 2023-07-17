#include "etl.h"

#include <ctype.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

#define SIZE (27)

int convert(const legacy_map *input, size_t input_len, new_map **output) {
  new_map arr[SIZE];
  memset(arr, 0, sizeof(arr));

  for (size_t i = 0; i < input_len; i++) {
    int len = strlen(input[i].keys);
    int value = input[i].value;
    for (int j = 0; j < len; j++) {
      char c = tolower(input[i].keys[j]);
      int ndx = c - 'a';
      arr[ndx].key = c;
      arr[ndx].value = value;
    }
  }
  *output = (new_map *)malloc(sizeof(new_map *) * SIZE);
  memset(*output, 0, sizeof(new_map *) * SIZE);

  int ct = 0;
  for (int i = 0; i < SIZE; i++) {
    if (arr[i].value != 0) {
      (*output)[ct].key = arr[i].key;
      (*output)[ct].value = arr[i].value;
      ct++;
    }
  }
  return ct;
}
