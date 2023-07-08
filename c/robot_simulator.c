#include "robot_simulator.h"

#include <stdio.h>

robot_status_t robot_create(robot_direction_t direction, int x, int y) {
  robot_position_t pos = (robot_position_t){.x = x, .y = y};
  return (robot_status_t){direction, pos};
}

void robot_move(robot_status_t *robot, const char *commands) {
  while (*commands != '\0') {
    int dx = 0, dy = 0;
    switch (*(commands++)) {
    case 'L':
      robot->direction = (robot->direction - 1 + DIRECTION_MAX) % DIRECTION_MAX;
      break;
    case 'R':
      robot->direction = (robot->direction + 1) % DIRECTION_MAX;
      break;
    case 'A':
      switch (robot->direction) {
      case DIRECTION_NORTH:
        dy = 1;
        break;
      case DIRECTION_EAST:
        dx = 1;
        break;
      case DIRECTION_WEST:
        dx = -1;
        break;
      case DIRECTION_SOUTH:
        dy = -1;
        break;
      default:
        break;
      }
      robot->position.x += dx;
      robot->position.y += dy;
      break;
    }
  }
}
