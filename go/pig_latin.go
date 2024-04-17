package piglatin

import (
	"regexp"
	"strings"
)

func Word(word string) string {
	re := regexp.MustCompile(`^([aeiuo]|xr|yt)`)
	if re.MatchString(word) {
		return word + "ay"
	}

	re = regexp.MustCompile(`^([^aeiou]*qu)(.+)$`)
	if match := re.FindStringSubmatch(word); match != nil {
		return match[2] + match[1] + "ay"
	}

	re = regexp.MustCompile(`^([^aeiou]+|.)(y.+)$`)
	if match := re.FindStringSubmatch(word); match != nil {
		return match[2] + match[1] + "ay"
	}

	re = regexp.MustCompile(`^([^aeiou]+)(.+)$`)
	if match := re.FindStringSubmatch(word); match != nil {
		return match[2] + match[1] + "ay"
	}

	return word
}

func Sentence(sentence string) string {
	words := strings.Split(sentence, " ")
	arr := make([]string, len(words))
	for i, w := range words {
		arr[i] = Word(w)
	}
	return strings.Join(arr, " ")
}
