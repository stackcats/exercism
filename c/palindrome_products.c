#include "palindrome_products.h"

#include <limits.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define SIZE (1024)

void free_factor(factor_t *factor);
factor_t *init_factor(int a, int b);
product_t *init_product();
product_t *set_smallest(product_t *pt, int i, int j);
product_t *set_largest(product_t *pt, int i, int j);
bool is_palindrome(int n);

product_t *get_palindrome_product(int start, int end) {
  product_t *pt = init_product();
  if (start > end) {
    sprintf(pt->error, "invalid input: min is %d and max is %d", start, end);
    return pt;
  }

  for (int i = start; i <= end; i++) {
    for (int j = i; j <= end; j++) {
      int n = i * j;
      if (is_palindrome(n)) {
        set_largest(pt, i, j);
        set_smallest(pt, i, j);
      }
    }
  }
  if (pt->factors_lg == NULL && pt->factors_sm == NULL) {
    sprintf(pt->error, "no palindrome with factors in the range %d to %d",
            start, end);
  }
  return pt;
}

factor_t *init_factor(int a, int b) {
  factor_t *f = malloc(sizeof(factor_t));
  f->factor_a = a;
  f->factor_b = b;
  f->next = NULL;
  return f;
}

void free_factor(factor_t *factor) {
  while (factor != NULL) {
    factor_t *p = factor;
    factor = factor->next;
    free(p);
  }
  free(factor);
}

void free_product(product_t *product) {
  if (product == NULL)
    return;
  free_factor(product->factors_lg);
  free_factor(product->factors_sm);
  free(product);
}

product_t *init_product() {
  product_t *pt = malloc(sizeof(product_t));
  memset(pt, 0, sizeof(product_t));
  pt->largest = INT_MIN;
  pt->smallest = INT_MAX;
  return pt;
}

product_t *set_largest(product_t *pt, int i, int j) {
  int n = i * j;
  if (n > pt->largest) {
    pt->largest = n;
    free_factor(pt->factors_lg);
    factor_t *f = init_factor(i, j);
    pt->factors_lg = f;
  } else if (n == pt->largest) {
    pt->largest = n;
    factor_t *f = init_factor(i, j);
    f->next = pt->factors_lg;
    pt->factors_lg = f;
  }

  return pt;
}

product_t *set_smallest(product_t *pt, int i, int j) {
  int n = i * j;
  if (n < pt->smallest) {
    pt->smallest = n;
    free_factor(pt->factors_sm);
    factor_t *f = init_factor(i, j);
    pt->factors_sm = f;
  } else if (n == pt->smallest) {
    pt->smallest = n;
    factor_t *f = init_factor(i, j);
    f->next = pt->factors_sm;
    pt->factors_sm = f;
  }
  return pt;
}

bool is_palindrome(int n) {
  int m = 0;
  int x = n;
  while (x > 0) {
    m = m * 10 + x % 10;
    x /= 10;
  }
  return m == n;
}
