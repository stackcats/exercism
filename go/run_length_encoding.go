package encode

import (
	"fmt"
	"strings"
	"unicode"
)

func encode(ct int, c rune) string {
	if ct == 0 {
		return ""
	}
	if ct == 1 {
		return string(c)
	}
	return fmt.Sprintf("%d%c", ct, c)
}

func RunLengthEncode(input string) string {
	var last rune
	ct := 0
	s := ""
	for _, c := range input {
		if last == c {
			ct++
		} else {
			s += encode(ct, last)
			ct = 1
			last = c
		}
	}

	s += encode(ct, last)
	return s
}

func decode(ct int, c rune) string {
	if ct < 2 {
		return string(c)
	}
	return strings.Repeat(string(c), ct)
}

func RunLengthDecode(input string) string {
	ct := 0
	s := ""
	for _, c := range input {
		if unicode.IsDigit(c) {
			ct = ct*10 + int(c-'0')
		} else {
			s += decode(ct, c)
			ct = 0
		}
	}

	return s
}
