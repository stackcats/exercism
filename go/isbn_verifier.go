package isbn

import (
	"strings"
	"unicode"
)

func IsValidISBN(isbn string) bool {
	isbn = strings.ReplaceAll(isbn, "-", "")

	if len(isbn) != 10 {
		return false
	}

	sum := 0
	for i, c := range isbn {
		if i == 9 && c == 'X' {
			sum += 10 * (10 - i)
		} else if unicode.IsDigit(c) {
			sum += int(c-'0') * (10 - i)
		} else {
			return false
		}
	}
	return sum%11 == 0
}
