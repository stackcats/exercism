package isogram

import (
	"strings"
	"unicode"
)

// IsIsogram determine if a word or phrase without a repeating letter
// however spaces and hyphens are allowed to appear multiple times.
func IsIsogram(word string) bool {
	table := make(map[rune]bool)

	for _, ch := range strings.ToLower(word) {
		if !unicode.IsLetter(ch) {
			continue
		}

		if _, ok := table[ch]; ok {
			return false
		}

		table[ch] = true
	}

	return true
}
