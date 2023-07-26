from typing import List, Self
from collections import Counter

RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
SUITS = ['D', 'C', 'H', 'S']


class Hand:

    def __init__(self, cardstr: str):
        cards = cardstr.split()
        self.ranks = []
        self.suits = []
        for card in cards:
            if len(card) == 2:
                self.ranks.append(RANKS.index(card[0]))
            else:
                self.ranks.append(RANKS.index(card[:2]))
            self.suits.append(SUITS.index(card[-1]))

        self.ranks.sort()

        self.cardstr = cardstr

        self.category = self._check_category()

    def _check_category(self) -> int:
        if self._is_straight_flush():
            return 8
        if self._is_four_kind():
            return 7
        if self._is_full_house():
            return 6
        if self._is_flush():
            return 5
        if self._is_straight():
            return 4
        if self._is_three_kind():
            return 3
        if self._is_two_pair():
            return 2
        if self._is_one_pair():
            return 1
        self.best = self.ranks[::-1]
        return 0

    def _is_straight(self) -> bool:
        if self.ranks == [0, 1, 2, 3, 12]:
            self.best = [3, 2, 1, 0, 12]
            return True
        for i in range(1, 5):
            if self.ranks[i] - self.ranks[i - 1] != 1:
                return False
        self.best = self.ranks[::-1]
        return True

    def _is_flush(self) -> bool:
        st = set(self.suits)
        if len(st) == 1:
            self.best = self.ranks[::-1]
            return True
        return False

    def _is_straight_flush(self) -> bool:
        return self._is_flush() and self._is_straight()

    def _find_kinds(self, target: int, num: int) -> bool:
        ct = Counter(self.ranks)
        targets = []
        others = []
        for (k, v) in ct.items():
            if v == target:
                targets.append(k)
            else:
                others.append(k)
        if len(targets) == num:
            others.sort(reverse=True)
            targets.sort(reverse=True)
            self.best = targets + others
            return True
        return False

    def _is_four_kind(self) -> bool:
        return self._find_kinds(4, 1)

    def _is_full_house(self) -> bool:
        ct = Counter(self.ranks)
        v2 = []
        v3 = []

        for (k, v) in ct.items():
            if v == 3:
                v3.append(k)
            elif v == 2:
                v2.append(k)

        if v2 != [] and v3 != []:
            self.best = [v3[0], v2[0]]
            return True

        return False

    def _is_three_kind(self) -> bool:
        return self._find_kinds(3, 1)

    def _is_two_pair(self) -> bool:
        return self._find_kinds(2, 2)

    def _is_one_pair(self) -> bool:
        return self._find_kinds(2, 1)

    def cmp(self, other: Self) -> int:
        if self.category == other.category:
            if self.best == other.best:
                return 0
            if self.best < other.best:
                return -1
            return 1
        return self.category - other.category


def best_hands(hands: List[str]) -> List[str]:
    x, *xs = [Hand(h) for h in hands]
    res = [x]
    for x in xs:
        if x.cmp(res[0]) == 0:
            res.append(x)
        elif x.cmp(res[0]) > 0:
            res = [x]

    return [r.cardstr for r in res]
