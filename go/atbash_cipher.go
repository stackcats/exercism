package atbash

import (
	"strings"
	"unicode"
)

func Atbash(s string) string {
	t := []rune{}
	i := 0
	for _, c := range strings.ToLower(s) {
		var ch rune
		if unicode.IsLetter(c) {
			ch = 'z' - c + 'a'
		} else if unicode.IsDigit(c) {
			ch = c
		} else {
			continue
		}
		if i == 5 {
			t = append(t, ' ')
			i = 0
		}
		t = append(t, ch)
		i++
	}
	return string(t)
}
