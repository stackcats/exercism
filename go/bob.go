package bob

import (
	"regexp"
	"strings"
)

func Hey(remark string) string {
	re := regexp.MustCompile(`\s`)
	remark = re.ReplaceAllString(remark, "")
	if remark == "" {
		return "Fine. Be that way!"
	}
	isQuestion := strings.HasSuffix(remark, "?")
	re = regexp.MustCompile(`[A-Z]`)
	isYelling := re.MatchString(remark) && strings.ToUpper(remark) == remark
	if isQuestion && isYelling {
		return "Calm down, I know what I'm doing!"
	}

	if isQuestion {
		return "Sure."
	}

	if isYelling {
		return "Whoa, chill out!"
	}

	return "Whatever."
}
