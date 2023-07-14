#include "complex_numbers.h"

#include <math.h>

complex_t c_add(complex_t a, complex_t b) {
  complex_t c = {.real = a.real + b.real, .imag = a.imag + b.imag};
  return c;
}

complex_t c_sub(complex_t a, complex_t b) {
  complex_t c = {.real = a.real - b.real, .imag = a.imag - b.imag};
  return c;
}

complex_t c_mul(complex_t a, complex_t b) {
  complex_t c = {.real = a.real * b.real - a.imag * b.imag,
                 .imag = a.imag * b.real + a.real * b.imag};
  return c;
}

complex_t c_div(complex_t a, complex_t b) {
  double denom = b.real * b.real + b.imag * b.imag;
  complex_t c = {.real = (a.real * b.real + a.imag * b.imag) / denom,
                 .imag = (a.imag * b.real - a.real * b.imag) / denom};
  return c;
}

double c_abs(complex_t x) { return sqrt(x.real * x.real + x.imag * x.imag); }

complex_t c_conjugate(complex_t x) {
  complex_t y = {.real = x.real, .imag = -x.imag};
  return y;
}

double c_real(complex_t x) { return x.real; }

double c_imag(complex_t x) { return x.imag; }

complex_t c_exp(complex_t x) {
  complex_t y = {.real = cos(x.imag) * exp(x.real),
                 .imag = sin(x.imag) * exp(x.real)};
  return y;
}
