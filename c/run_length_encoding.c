#include "run_length_encoding.h"

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  char *s;
  size_t len;
  size_t cap;
} string_t, *string;

string new_string(size_t cap);
void free_string(string s);
char *c_str(string s);
string add_char(string str, char ch);
void print_string(string str);

char *encode(const char *s) {
  size_t len = strlen(s);
  char *res = (char *)malloc((len + 1) * sizeof(char));
  if (res == NULL)
    return NULL;
  memset(res, 0, (len + 1) * sizeof(char));
  int ct = 0;
  char lastChar = 0;
  char tmp[256];

  while (*s != '\0') {
    if (*s == lastChar) {
      ct++;
    } else {
      if (ct > 1) {
        sprintf(tmp, "%d%c", ct, lastChar);
        strcat(res, tmp);
      } else {
        sprintf(tmp, "%c", lastChar);
        strcat(res, tmp);
      }

      ct = 1;
      lastChar = *s;
    }
    s++;
  }
  if (ct > 1) {
    sprintf(tmp, "%d%c", ct, lastChar);
    strcat(res, tmp);
  } else {
    sprintf(tmp, "%c", lastChar);
    strcat(res, tmp);
  }
  return res;
}

char *decode(const char *s) {
  int len = strlen(s);
  int ct = 0;
  string res = new_string(16);

  for (int i = 0; i < len; i++) {
    if (isdigit(s[i])) {
      ct = ct * 10 + (s[i] - '0');
    } else {
      if (ct == 0)
        ct = 1;
      while (ct > 0) {
        add_char(res, s[i]);
        ct--;
      }
    }
  }
  char *r = c_str(res);
  free_string(res);
  return r;
}

string new_string(size_t cap) {
  string str = (string)malloc(sizeof(string_t));
  str->s = (char *)malloc(sizeof(char) * cap);
  memset(str->s, 0, sizeof(char) * cap);
  str->len = 0;
  str->cap = cap;
  return str;
}

void free_string(string s) {
  if (s == NULL)
    return;
  if (s->s != NULL)
    free(s->s);
  free(s);
}

char *c_str(string s) {
  int len = s->len + 1;
  char *r = (char *)malloc(sizeof(char) * len);
  memset(r, 0, sizeof(char) * len);
  strncpy(r, s->s, s->len);
  return r;
}

string add_char(string str, char ch) {
  if (str->len >= str->cap) {
    str->cap *= 2;
    str->s = (char *)realloc(str->s, str->cap * sizeof(char));
  }
  str->s[str->len] = ch;
  str->len += 1;
  return str;
}
