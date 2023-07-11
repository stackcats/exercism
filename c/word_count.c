#include "word_count.h"

#include <ctype.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define SIZE 1024

bool is_apostrophe(const char *in, int i);

int count_words(const char *input_text, word_count_word_t *res) {
  char lower_input_text[MAX_WORD_LENGTH + 1];
  size_t len = strlen(input_text);

  for (size_t i = 0; i < len; i++) {
    lower_input_text[i] = tolower(input_text[i]);
  }

  lower_input_text[len] = '\0';

  bool in_word = false;
  int ct = 0;
  int start = 0;

  // include \0 as end
  for (size_t i = 0; i < len + 1; i++) {
    if (isalnum(lower_input_text[i]) || is_apostrophe(lower_input_text, i)) {
      if (!in_word) {
        in_word = true;
        start = i;
      }
      continue;
    }

    if (!in_word) {
      continue;
    }

    in_word = false;

    int word_len = i - start;
    if (word_len > MAX_WORD_LENGTH) {
      return EXCESSIVE_LENGTH_WORD;
    }

    char word[MAX_WORD_LENGTH];
    strncpy(word, lower_input_text + start, word_len);
    word[word_len] = '\0';

    bool is_new_word = true;
    for (int j = 0; j < ct; j++) {
      if (!strcmp(word, res[j].text)) {
        res[j].count++;
        is_new_word = false;
        break;
      }
    }

    if (is_new_word) {
      if (ct >= MAX_WORDS) {
        return EXCESSIVE_NUMBER_OF_WORDS;
      }
      strcpy(res[ct].text, word);
      res[ct].count = 1;
      ct++;
    }
  }

  return ct;
}

bool is_apostrophe(const char *in, int i) {
  return in[i] == '\'' && i - 1 >= 0 && isalpha(in[i - 1]) &&
         isalpha(in[i + 1]);
}
