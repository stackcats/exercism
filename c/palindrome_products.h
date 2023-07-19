#ifndef PALINDROME_PRODUCTS_H
#define PALINDROME_PRODUCTS_H

#define MAXERR 100

typedef struct factor {
  int factor_a;
  int factor_b;
  struct factor *next;
} factor_t;

typedef struct {
  int largest;
  int smallest;
  char error[MAXERR];
  factor_t *factors_sm;
  factor_t *factors_lg;
} product_t;

product_t *get_palindrome_product(int from, int to);
void free_product(product_t *p);

#endif
