#include "allergies.h"

#include <math.h>
#include <stdlib.h>
#include <string.h>

bool is_allergic_to(allergen_t allergen, int score) {
  return (int)pow(2, allergen) & score;
}

allergen_list_t get_allergens(int score) {
  allergen_list_t list;

  list.count = 0;

  for (allergen_t allergen = ALLERGEN_EGGS; allergen < ALLERGEN_COUNT;
       allergen++) {
    if (is_allergic_to(allergen, score)) {
      list.allergens[allergen] = true;
      list.count++;
    }
  }

  return list;
}
