#include "matching_brackets.h"

#include <stddef.h>
#include <stdlib.h>
#include <string.h>

bool is_paired(const char *input) {
  char *stack = malloc(strlen(input) + 16);
  size_t top = 0;
  while (*input != '\0') {
    switch (*input) {
    case '(':
      stack[top++] = '(';
      break;
    case ')':
      if (top == 0 || stack[top - 1] != '(') {
        return false;
      }
      top--;
      break;
    case '[':
      stack[top++] = '[';
      break;
    case ']':
      if (top == 0 || stack[top - 1] != '[') {
        return false;
      }
      top--;
      break;
    case '{':
      stack[top++] = '{';
      break;
    case '}':
      if (top == 0 || stack[top - 1] != '{') {
        return false;
      }
      top--;
      break;
    default:
      break;
    }
    input++;
  }

  free(stack);
  return top == 0;
}
