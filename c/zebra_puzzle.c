#include "zebra_puzzle.h"
#include <string.h>

enum Colors { red, green, ivory, yellow, blue };
enum Mans { Englishman, Spaniard, Ukrainian, Norwegian, Japanese };
enum Drinks { coffee, tea, milk, juice, water };
enum Animals { dog, snails, fox, horse, zebra };
enum Smokes { OldGold, Kools, Chesterfields, Parliaments, LuckyStrike };

enum Attrib { C, M, D, A, S };

enum HouseStatus { Invalid, Underfull, Valid };

static int checkHouses(int ha[5][5]) {
  int c_add = 0, c_or = 0;
  int m_add = 0, m_or = 0;
  int d_add = 0, d_or = 0;
  int a_add = 0, a_or = 0;
  int s_add = 0, s_or = 0;

  if (ha[2][D] >= 0 && ha[2][D] != milk)
    return Invalid;

  if (ha[0][M] >= 0 && ha[0][M] != Norwegian)
    return Invalid;

  if (ha[0][C] >= 0 && ha[0][C] == green) {
    return Invalid;
  }
  for (int i = 0; i < 5; i++) {
    if (ha[i][C] >= 0) {
      c_add += (1 << ha[i][C]);
      c_or |= (1 << ha[i][C]);
    }
    if (ha[i][M] >= 0) {
      m_add += (1 << ha[i][M]);
      m_or |= (1 << ha[i][M]);
    }
    if (ha[i][D] >= 0) {
      d_add += (1 << ha[i][D]);
      d_or |= (1 << ha[i][D]);
    }
    if (ha[i][A] >= 0) {
      a_add += (1 << ha[i][A]);
      a_or |= (1 << ha[i][A]);
    }
    if (ha[i][S] >= 0) {
      s_add += (1 << ha[i][S]);
      s_or |= (1 << ha[i][S]);
    }

    if ((ha[i][M] >= 0 && ha[i][C] >= 0) &&
        ((ha[i][M] == Englishman && ha[i][C] != red) ||
         (ha[i][M] != Englishman && ha[i][C] == red)))
      return Invalid;

    if ((ha[i][M] >= 0 && ha[i][A] >= 0) &&
        ((ha[i][M] == Spaniard && ha[i][A] != dog) ||
         (ha[i][M] != Spaniard && ha[i][A] == dog)))
      return Invalid;

    if ((ha[i][M] >= 0 && ha[i][D] >= 0) &&
        ((ha[i][M] == Ukrainian && ha[i][D] != tea) ||
         (ha[i][M] != Ukrainian && ha[i][D] == tea)))
      return Invalid;

    if (ha[i][C] >= 0 && ha[i][C] == green) {
      if (ha[i - 1][C] >= 0 && ha[i - 1][C] != ivory) {
        return Invalid;
      }
    }

    if ((ha[i][C] >= 0 && ha[i][D] >= 0) &&
        ((ha[i][C] == green && ha[i][D] != coffee) ||
         (ha[i][C] != green && ha[i][D] == coffee)))
      return Invalid;

    if ((ha[i][S] >= 0 && ha[i][A] >= 0) &&
        ((ha[i][S] == OldGold && ha[i][A] != snails) ||
         (ha[i][S] != OldGold && ha[i][A] == snails)))
      return Invalid;

    if ((ha[i][S] >= 0 && ha[i][C] >= 0) &&
        ((ha[i][S] == Kools && ha[i][C] != yellow) ||
         (ha[i][S] != Kools && ha[i][C] == yellow)))
      return Invalid;

    if (ha[i][S] == Chesterfields) {
      if (i == 0 && ha[i + 1][A] >= 0 && ha[i + 1][A] != fox)
        return Invalid;
      else if (i == 4 && ha[i - 1][A] != fox)
        return Invalid;
      else if (ha[i + 1][A] >= 0 && ha[i + 1][A] != fox && ha[i - 1][A] != fox)
        return Invalid;
    }

    if (ha[i][S] == Kools) {
      if (i == 0 && ha[i + 1][A] >= 0 && ha[i + 1][A] != horse)
        return Invalid;
      else if (i == 4 && ha[i - 1][A] != horse)
        return Invalid;
      else if (ha[i + 1][A] >= 0 && ha[i + 1][A] != horse &&
               ha[i - 1][A] != horse)
        return Invalid;
    }

    if ((ha[i][S] >= 0 && ha[i][D] >= 0) &&
        ((ha[i][S] == LuckyStrike && ha[i][D] != juice) ||
         (ha[i][S] != LuckyStrike && ha[i][D] == juice)))
      return Invalid;

    if ((ha[i][M] >= 0 && ha[i][S] >= 0) &&
        ((ha[i][M] == Japanese && ha[i][S] != Parliaments) ||
         (ha[i][M] != Japanese && ha[i][S] == Parliaments)))
      return Invalid;

    if (ha[i][M] == Norwegian &&
        ((i < 4 && ha[i + 1][C] >= 0 && ha[i + 1][C] != blue) ||
         (i > 0 && ha[i - 1][C] != blue)))
      return Invalid;
  }

  if ((c_add != c_or) || (m_add != m_or) || (d_add != d_or) ||
      (a_add != a_or) || (s_add != s_or)) {
    return Invalid;
  }

  if ((c_add != 31) || (m_add != 31) || (d_add != 31) || (a_add != 31) ||
      (s_add != 31)) {
    return Underfull;
  }

  return Valid;
}

static int bruteFill(int ha[5][5], int hno, int attr) {
  int stat = checkHouses(ha);
  if ((stat == Valid) || (stat == Invalid))
    return stat;

  int hb[5][5];
  memcpy(hb, ha, sizeof(int) * 5 * 5);
  for (int i = 0; i < 5; i++) {
    hb[hno][attr] = i;
    stat = checkHouses(hb);
    if (stat != Invalid) {
      int nexthno, nextattr;
      if (attr < 4) {
        nextattr = attr + 1;
        nexthno = hno;
      } else {
        nextattr = 0;
        nexthno = hno + 1;
      }

      stat = bruteFill(hb, nexthno, nextattr);
      if (stat != Invalid) {
        memcpy(ha, hb, sizeof(int) * 5 * 5);
        return stat;
      }
    }
  }

  return Invalid;
}

static char *nationality[5] = {"Englishman", "Spaniard", "Ukrainian",
                               "Norwegian", "Japanese"};

static int ha[5][5] = {{-1, -1, -1, -1, -1},
                       {-1, -1, -1, -1, -1},
                       {-1, -1, -1, -1, -1},
                       {-1, -1, -1, -1, -1},
                       {-1, -1, -1, -1, -1}};

const char *drinks_water(void) {
  bruteFill(ha, 0, 0);

  for (int i = 0; i < 5; i++) {
    if (ha[i][D] == water) {
      return nationality[ha[i][M]];
    }
  }
  return "unreachable";
}

const char *owns_zebra(void) {
  bruteFill(ha, 0, 0);

  for (int i = 0; i < 5; i++) {
    if (ha[i][A] == zebra) {
      return nationality[ha[i][M]];
    }
  }
  return "unreachable";
}
