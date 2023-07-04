#include "grade_school.h"

#include <stdbool.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

void init_roster(roster_t *roster) { roster->count = 0; }

int compare(const void *s1, const void *s2);

bool add_student(roster_t *roster, char name[], uint8_t grade) {
  for (size_t i = 0; i < roster->count; i++) {
    if (!strcmp(roster->students[i].name, name)) {
      return false;
    }
  }
  roster->students[roster->count].grade = grade;
  strcpy(roster->students[roster->count].name, name);
  roster->count++;
  qsort(roster->students, roster->count, sizeof(student_t), compare);
  return true;
}

int compare(const void *s1, const void *s2) {
  student_t st1 = *(student_t *)s1;
  student_t st2 = *(student_t *)s2;
  return st1.grade == st2.grade ? strcmp(st1.name, st2.name)
                                : st1.grade - st2.grade;
}

roster_t get_grade(roster_t *roster, int grade) {
  roster_t res;
  init_roster(&res);
  for (size_t i = 0; i < roster->count; i++) {
    if (roster->students[i].grade == grade) {
      res.students[res.count] = roster->students[i];
      res.count++;
    }
  }
  return res;
}
