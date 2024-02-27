package anagram

import (
	"reflect"
	"strings"
)

func to_map(s string) map[rune]int {
	mp := map[rune]int{}
	for _, c := range s {
		mp[c] += 1
	}
	return mp
}

func Detect(subject string, candidates []string) []string {
	lower := strings.ToLower(subject)
	mp := to_map(lower)
	arr := []string{}
	for _, candidate := range candidates {
		l := strings.ToLower(candidate)
		if l == lower {
			continue
		}
		m := to_map(l)
		if reflect.DeepEqual(mp, m) {
			arr = append(arr, candidate)
		}
	}
	return arr
}
