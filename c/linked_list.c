#include "linked_list.h"

#include <stddef.h>
#include <stdlib.h>

typedef struct list_node {
  struct list_node *prev, *next;
  ll_data_t data;
} list_node_t;

list_node_t *create_node(ll_data_t data);

typedef struct list {
  struct list_node *first, *last;
  size_t count;
} list_t;

struct list *list_create(void) {
  list_t *list = malloc(sizeof(list_t));
  if (list == NULL) {
    return NULL;
  }

  list->first = NULL;
  list->last = NULL;
  list->count = 0;

  return list;
}

size_t list_count(const struct list *list) { return list->count; }

void list_push(struct list *list, ll_data_t item_data) {
  list_node_t *node = create_node(item_data);
  if (node == NULL) {
    return;
  }

  list->count++;

  if (list->first == NULL) {
    list->first = node;
    list->last = node;
    return;
  }

  list->last->next = node;
  node->prev = list->last;
  list->last = node;
}

ll_data_t list_pop(struct list *list) {
  list->count--;
  list_node_t *node = list->last;
  list->last = node->prev;
  if (list->last == NULL) {
    list->first = NULL;
  } else {
    list->last->next = NULL;
  }

  ll_data_t data = node->data;
  free(node);
  return data;
}

void list_unshift(struct list *list, ll_data_t item_data) {
  list_node_t *node = create_node(item_data);
  if (node == NULL) {
    return;
  }

  list->count++;

  if (list->first == NULL) {
    list->first = node;
    list->last = node;
    return;
  }

  node->next = list->first;
  list->first->prev = node;
  list->first = node;
}

ll_data_t list_shift(struct list *list) {
  list->count--;
  list_node_t *node = list->first;
  list->first = list->first->next;
  if (list->first == NULL) {
    list->last = NULL;
  } else {
    list->first->prev = NULL;
  }

  ll_data_t data = node->data;
  free(node);
  return data;
}

void list_delete(struct list *list, ll_data_t data) {
  list_node_t *prev = NULL;
  list_node_t *curr = list->first;
  while (curr != NULL) {
    if (curr->data == data) {
      break;
    }
    prev = curr;
    curr = curr->next;
  }

  if (curr == NULL) {
    // not found
    return;
  }

  if (prev == NULL) {
    // remove the first node
    list_shift(list);
    return;
  }

  if (curr == list->last) {
    // remove the last node
    list_pop(list);
    return;
  }
  list->count--;
  list_node_t *next = curr->next;
  next->prev = prev;
  prev->next = next;
  free(curr);
}

void list_destroy(struct list *list) {
  while (list->first != list->last) {
    list_node_t *node = list->first;
    list->first = node->next;
    free(node);
  }
  free(list);
  list = NULL;
}

list_node_t *create_node(ll_data_t data) {
  list_node_t *node = malloc(sizeof(list_node_t));
  if (node == NULL) {
    return NULL;
  }
  node->data = data;
  node->prev = NULL;
  node->next = NULL;
  return node;
}
