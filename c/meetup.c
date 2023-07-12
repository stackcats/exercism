#include "meetup.h"

#include <stdbool.h>
#include <string.h>

int day_to_num(const char *week);
int zeller(int year, int month, int day);
bool is_leap(int year);
int days(int year, int month);

int day_to_num(const char *week) {
  if (!strcmp(week, "Monday")) {
    return 0;
  } else if (!strcmp(week, "Tuesday")) {
    return 1;
  } else if (!strcmp(week, "Wednesday")) {
    return 2;
  } else if (!strcmp(week, "Thursday")) {
    return 3;
  } else if (!strcmp(week, "Friday")) {
    return 4;
  } else if (!strcmp(week, "Saturday")) {
    return 5;
  } else {
    return 6;
  }
}

int zeller(int year, int month, int day) {
  if (month == 1 || month == 2) {
    month += 12;
    year--;
  }
  return (day + 2 * month + 3 * (month + 1) / 5 + year + year / 4 - year / 100 +
          year / 400) %
         7;
}

bool is_leap(int year) {
  return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
}

int days(int year, int month) {
  switch (month) {
  case 1:
  case 3:
  case 5:
  case 7:
  case 8:
  case 10:
  case 12:
    return 31;
  case 4:
  case 6:
  case 9:
  case 11:
    return 30;
  }
  return is_leap(year) ? 29 : 28;
}

int meetup_day_of_month(unsigned int year, unsigned int month, const char *week,
                        const char *day_of_week) {
  int d = day_to_num(day_of_week);

  if (!strcmp(week, "teenth")) {
    for (int i = 13; i < 20; i++) {
      if (zeller(year, month, i) == d) {
        return i;
      }
    }
  }
  int ct;
  if (!strcmp(week, "first")) {
    ct = 1;
  } else if (!strcmp(week, "second")) {
    ct = 2;
  } else if (!strcmp(week, "third")) {
    ct = 3;
  } else if (!strcmp(week, "fourth")) {
    ct = 4;
  } else if (!strcmp(week, "fifth")) {
    ct = 5;
  } else if (!strcmp(week, "last")) {
    for (int i = days(year, month); i >= 0; i--) {
      if (zeller(year, month, i) == d) {
        return i;
      }
    }
  }
  for (int i = 1; i < days(year, month); i++) {
    if (zeller(year, month, i) == d) {
      ct--;
      if (ct <= 0) {
        return i;
      }
    }
  }

  return 0;
}
