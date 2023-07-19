#include "triangle.h"

void swap(double *a, double *b);
bool is_triangle(triangle_t sides);

bool is_equilateral(triangle_t sides) {
  if (!is_triangle(sides))
    return false;
  if (sides.a != sides.b || sides.a != sides.c)
    return false;
  return true;
}

bool is_isosceles(triangle_t sides) {
  if (!is_triangle(sides))
    return false;
  if (sides.a == sides.b || sides.a == sides.c || sides.b == sides.c)
    return true;
  return false;
}

bool is_scalene(triangle_t sides) {
  if (!is_triangle(sides))
    return false;
  if (sides.a == sides.b || sides.a == sides.c || sides.b == sides.c)
    return false;
  return true;
}

void swap(double *a, double *b) {
  double t = *a;
  *a = *b;
  *b = t;
}

bool is_triangle(triangle_t sides) {
  if (sides.a == 0 || sides.b == 0 || sides.c == 0)
    return false;

  if (sides.a < sides.c) {
    swap(&sides.a, &sides.c);
  }
  if (sides.b < sides.c) {
    swap(&sides.b, &sides.c);
  }
  if (sides.a < sides.b) {
    swap(&sides.a, &sides.b);
  }

  if (sides.b + sides.c < sides.a)
    return false;
  if (sides.a - sides.b > sides.c)
    return false;
  return true;
}
