package scrabble

import (
	"strings"
	"unicode"
)

var scoreTable = map[string]int{
	"aeioulnrst": 1,
	"dg":         2,
	"bcmp":       3,
	"fhvwy":      4,
	"k":          5,
	"jx":         8,
	"qz":         10,
}

func point(r rune) int {
	l := unicode.ToLower(r)

	for s, p := range scoreTable {
		if strings.ContainsRune(s, l) {
			return p
		}
	}

	return 0
}

// Score Given a word, compute the scrabble score for that word.
func Score(word string) (sum int) {
	for _, ch := range word {
		sum += point(ch)
	}
	return
}
