#include "binary_search_tree.h"

#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  int *data;
  int size;
  int cap;
} array;

array *init_array(int cap);
void free_array(array *arr);
array *append(array *arr, int n);

node_t *init_node(int data);
node_t *add_node(node_t *tree, int data);
void dlr(node_t *tree, array *arr);

node_t *build_tree(int data[], size_t tree_data_len) {
  node_t *tree = NULL;
  for (size_t i = 0; i < tree_data_len; i++) {
    tree = add_node(tree, data[i]);
  }
  return tree;
}

void free_tree(node_t *tree) {
  if (tree == NULL) {
    return;
  }
  free_tree(tree->left);
  free_tree(tree->right);
  free(tree);
}

int *sorted_data(node_t *tree) {
  array *arr = init_array(16);
  dlr(tree, arr);
  int *data = (int *)malloc(sizeof(int) * arr->size);
  memcpy(data, arr->data, sizeof(int) * arr->size);
  free_array(arr);
  return data;
}

node_t *init_node(int data) {
  node_t *node = malloc(sizeof(node_t));
  if (node == NULL) {
    return NULL;
  }
  node->data = data;
  node->left = NULL;
  node->right = NULL;
  return node;
}

node_t *add_node(node_t *tree, int data) {
  if (tree == NULL) {
    return init_node(data);
  }
  if (tree->data >= data) {
    tree->left = add_node(tree->left, data);
  } else {
    tree->right = add_node(tree->right, data);
  }
  return tree;
}

void dlr(node_t *tree, array *arr) {
  if (tree == NULL)
    return;

  dlr(tree->left, arr);
  append(arr, tree->data);
  dlr(tree->right, arr);
}

array *init_array(int cap) {
  array *arr = malloc(sizeof(array));
  if (arr == NULL) {
    return NULL;
  }
  arr->size = 0;
  arr->cap = cap + 16;
  arr->data = malloc(sizeof(int) * cap);
  return arr;
}

void free_array(array *arr) {
  if (arr == NULL)
    return;
  free(arr->data);
  free(arr);
}

array *append(array *arr, int n) {
  if (arr->size >= arr->cap) {
    arr->cap *= 2;
    arr->data = realloc(arr->data, sizeof(int) * arr->cap);
  }
  arr->data[arr->size] = n;
  arr->size++;
  return arr;
}
