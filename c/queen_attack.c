#include "queen_attack.h"

#include <stdbool.h>
#include <stdlib.h>

bool is_valid(uint8_t n);
bool is_valid_position(position_t p);

attack_status_t can_attack(position_t queen_1, position_t queen_2) {
  if (!is_valid_position(queen_1)) {
    return INVALID_POSITION;
  }

  if (!is_valid_position(queen_2)) {
    return INVALID_POSITION;
  }

  // same position
  if (queen_1.row == queen_2.row && queen_1.column == queen_2.column) {
    return INVALID_POSITION;
  }

  // same row or same column
  if (queen_1.row == queen_2.row || queen_1.column == queen_2.column) {
    return CAN_ATTACK;
  }

  // diagonal
  int dx = abs(queen_1.row - queen_2.row);
  int dy = abs(queen_1.column - queen_2.column);
  if (dx == dy) {
    return CAN_ATTACK;
  }

  return CAN_NOT_ATTACK;
}

bool is_valid(uint8_t n) { return n < 8; }

bool is_valid_position(position_t p) {
  return is_valid(p.row) && is_valid(p.column);
}
