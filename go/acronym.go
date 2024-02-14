package acronym

import (
	"regexp"
	"strings"
)

func Abbreviate(s string) string {
	re := regexp.MustCompile(`[A-Z]+[a-z']*|[a-z]*`)
	arr := re.FindAll([]byte(s), -1)
	t := []byte{}
	for _, v := range arr {
		if len(v) > 0 {
			t = append(t, v[0])
		}
	}
	return strings.ToUpper(string(t))
}
