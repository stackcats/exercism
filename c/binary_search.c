#include "binary_search.h"

const int *binary_search(int value, const int *arr, size_t length) {
  if (arr == NULL || length == 0)
    return NULL;

  int start = 0;
  int end = length;
  while (start < end) {
    int mid = (int)((end - start) / 2) + start;
    if (arr[mid] == value) {
      return arr + mid;
    } else if (arr[mid] > value) {
      end = mid;
    } else {
      start = mid + 1;
    }
  }
  return NULL;
}
