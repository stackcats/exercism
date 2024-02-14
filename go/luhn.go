package luhn

import (
	"strconv"
	"strings"
)

// Valid determine a number whether or not it is valid per the Luhn formula.
func Valid(number string) bool {
	number = strings.Trim(number, " ")
	if len(number) <= 1 {
		return false
	}

	sum := 0
	pos := 1
	for i := len(number) - 1; i >= 0; i-- {
		if number[i] == ' ' {
			continue
		}

		n, err := strconv.Atoi(string(number[i]))
		if err != nil {
			return false
		}

		if pos%2 == 0 {
			n *= 2
			if n > 9 {
				n -= 9
			}
		}

		sum += n
		pos++
	}

	return sum%10 == 0
}
