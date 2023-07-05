#include "list_ops.h"

#include <stddef.h>
#include <stdlib.h>
#include <string.h>

list_t *new_list(size_t length, list_element_t elements[]) {
  list_t *new =
      (list_t *)malloc(sizeof(list_t) + sizeof(list_element_t) * length);
  if (new == NULL) {
    return NULL;
  }

  memcpy(new->elements, elements, sizeof(list_element_t) * length);
  new->length = length;

  return new;
}

list_t *append_list(list_t *list1, list_t *list2) {
  size_t total_length = list1->length + list2->length;

  list_t *new =
      (list_t *)malloc(sizeof(list_t) + sizeof(list_element_t) * total_length);
  if (new == NULL) {
    return NULL;
  }

  memcpy(new->elements, list1->elements,
         sizeof(list_element_t) * list1->length);
  memcpy(new->elements + list1->length, list2->elements,
         sizeof(list_element_t) * list2->length);

  new->length = total_length;

  return new;
}

list_t *filter_list(list_t *list, bool (*filter)(list_element_t)) {
  list_element_t *elements =
      (list_element_t *)malloc(sizeof(list_element_t) * list->length);
  if (elements == NULL) {
    return NULL;
  }

  size_t len = 0;
  for (size_t i = 0; i < list->length; i++) {
    if (filter(list->elements[i])) {
      elements[len++] = list->elements[i];
    }
  }

  list_t *new = new_list(len, elements);
  free(elements);
  return new;
}

size_t length_list(list_t *list) { return list->length; }

list_t *map_list(list_t *list, list_element_t (*map)(list_element_t)) {
  list_t *new = new_list(list->length, list->elements);
  if (new == NULL) {
    return NULL;
  }

  for (size_t i = 0; i < new->length; i++) {
    new->elements[i] = map(list->elements[i]);
  }
  return new;
}

list_element_t foldl_list(list_t *list, list_element_t initial,
                          list_element_t (*foldl)(list_element_t,
                                                  list_element_t)) {
  list_element_t acc = initial;

  for (size_t i = 0; i < list->length; i++) {
    acc = foldl(acc, list->elements[i]);
  }

  return acc;
}

list_element_t foldr_list(list_t *list, list_element_t initial,
                          list_element_t (*foldr)(list_element_t,
                                                  list_element_t)) {
  list_element_t acc = initial;

  for (size_t i = list->length; i > 0; i--) {
    acc = foldr(list->elements[i - 1], acc);
  }

  return acc;
}

list_t *reverse_list(list_t *list) {
  list_t *new = new_list(list->length, list->elements);
  if (new == NULL) {
    return NULL;
  }

  for (size_t i = 0, j = list->length; i + 1 < j; i++, j--) {
    list_element_t tmp = new->elements[i];
    new->elements[i] = new->elements[j - 1];
    new->elements[j - 1] = tmp;
  }

  return new;
}

void delete_list(list_t *list) { free(list); }
