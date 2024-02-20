package pangram

import (
	"strings"
	"unicode"
)

func IsPangram(input string) bool {
	input = strings.ToLower(input)
	mp := map[rune]bool{}
	for _, c := range input {
		if unicode.IsLetter(c) {
			mp[c] = true
		}
	}
	return len(mp) == 26
}
