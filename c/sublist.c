#include "sublist.h"

#include <stdbool.h>

bool sublist(int *a, int *b, size_t la, size_t lb);

comparison_result_t check_lists(int *list_to_compare, int *base_list,
                                size_t list_to_compare_element_count,
                                size_t base_list_element_count) {
  if (list_to_compare == NULL && base_list == NULL)
    return EQUAL;
  if (list_to_compare == NULL)
    return SUBLIST;
  if (base_list == NULL)
    return SUPERLIST;
  bool a = sublist(list_to_compare, base_list, list_to_compare_element_count,
                   base_list_element_count);
  bool b = sublist(base_list, list_to_compare, base_list_element_count,
                   list_to_compare_element_count);
  if (a && b)
    return EQUAL;
  if (a)
    return SUBLIST;
  if (b)
    return SUPERLIST;
  return UNEQUAL;
}

bool sublist(int *a, int *b, size_t la, size_t lb) {
  for (size_t i = 0; i < lb; i++) {
    bool flag = true;
    for (size_t j = 0, k = i; j < la; j++, k++) {
      if (a[j] != b[k]) {
        flag = false;
        break;
      }
    }
    if (flag)
      return true;
  }
  return false;
}
