package queenattack

import "errors"

func abs(a int) int {
    if a < 0 {
        return -a
    }
	return a
}

func isValidCol(x byte) bool {
    return x >= 'a' && x <= 'h'
}

func isValidRow(x byte) bool {
    return x >= '1' && x <= '8'
}

func isValid(p string) bool {
    return len(p) == 2 && isValidCol(p[0]) && isValidRow(p[1])
}

func CanQueenAttack(wp, bp string) (bool, error) {
    if !isValid(wp) || !isValid(bp) {
        return false, errors.New("invalid")
    }

    if wp == bp {
        return false, errors.New("invalid")
    }

	return wp[0] == bp[0] || wp[1] == bp[1] || abs(int(wp[0]) - int(bp[0])) == abs(int(wp[1]) - int(bp[1])), nil
}

