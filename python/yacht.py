YACHT = 0
ONES = 1
TWOS = 2
THREES = 3
FOURS = 4
FIVES = 5
SIXES = 6
FULL_HOUSE = 7
FOUR_OF_A_KIND = 8
LITTLE_STRAIGHT = 9
BIG_STRAIGHT = 10
CHOICE = 11


def score(dice, category):
    ct = {}
    for i in range(1, 7):
        ct[i] = 0

    for d in dice:
        ct[d] += 1

    if category in [ONES, TWOS, THREES, FOURS, FIVES, SIXES]:
        return ct[category] * category

    if category == CHOICE:
        return sum(dice)

    kv = sorted([(v, k) for (k, v) in ct.items()], reverse=True)
    
    if category == FULL_HOUSE:
        [(x, _), (y, _)] = kv[:2]
        if x == 3 and y == 2:
            return sum(dice)
        else:
            return 0

    if category == FOUR_OF_A_KIND:
        (x, n) = kv[0]
        if x >= 4:
            return n * 4
        else:
            return 0

    if category == YACHT:
        (x, n) = kv[0]
        if x == 5:
            return 50
        else:
            return 0
        
    dice = sorted(dice)
    
    if category == LITTLE_STRAIGHT:
        if dice == [1,2,3,4,5]:
            return 30
        return 0

    if category == BIG_STRAIGHT:
        if dice == [2,3,4,5,6]:
            return 30
        return 0
