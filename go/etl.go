package etl

import "strings"

func Transform(in map[int][]string) map[string]int {
	mp := map[string]int{}
	for k, v := range in {
		for _, c := range v {
			mp[strings.ToLower(c)] = k
		}
	}
	return mp
}
