#include "isogram.h"
#include <ctype.h>
#include <stdlib.h>

bool is_isogram(const char phrase[]) {
  if (!phrase)
    return false;
  bool hash[26] = {false};
  const char *p = phrase;
  while (*p != '\0') {
    if (isalpha(*p)) {
      size_t i = tolower(*p) - 'a';
      if (hash[i])
        return false;
      hash[i] = true;
    }
    p++;
  }

  return true;
}
