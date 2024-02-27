package wordcount

import (
	"regexp"
	"strings"
)

type Frequency map[string]int

func WordCount(phrase string) Frequency {
	re := regexp.MustCompile(`(\w+'\w+|\w+|\d+)`)
	arr := re.FindAllString(phrase, -1)
	freq := Frequency{}
	for _, each := range arr {
		freq[strings.ToLower(each)] += 1
	}
	return freq
}
