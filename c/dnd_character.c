#include "dnd_character.h"
#include <math.h>
#include <stdlib.h>
#include <time.h>

int ability(void) {
  int sum = 0;
  int min = 10;
  for (int i = 0; i < 4; i++) {
    int r = rand() % 6 + 1;
    sum += r;
    if (min > r) {
      min = r;
    }
  }

  return sum - min;
}

int modifier(int score) { return floor((score - 10) / 2.0); }

dnd_character_t make_dnd_character(void) {
  srand((unsigned int)time(NULL));
  dnd_character_t character = {
      .wisdom = ability(),
      .constitution = ability(),
      .intelligence = ability(),
      .dexterity = ability(),
      .strength = ability(),
      .charisma = ability(),
      .hitpoints = 10 + modifier(character.constitution),
  };
  return character;
}
