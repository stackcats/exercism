package logs

import "unicode/utf8"

func Application(log string) string {
	for _, c := range log {
		switch c {
		case '❗':
			return "recommendation"
		case '🔍':
			return "search"
		case '☀':
			return "weather"
		}
	}
	return "default"
}

func Replace(log string, oldRune, newRune rune) string {
	r := []rune{}
	for _, c := range log {
		if c == oldRune {
			r = append(r, newRune)
		} else {
			r = append(r, c)
		}
	}
	return string(r)
}

func WithinLimit(log string, limit int) bool {
	return utf8.RuneCountInString(log) <= limit
}
