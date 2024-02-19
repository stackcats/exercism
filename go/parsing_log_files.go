package parsinglogfiles

import (
	"fmt"
	"regexp"
)

func IsValidLine(text string) bool {
	re := regexp.MustCompile(`^\[(TRC|DBG|INF|WRN|ERR|FTL)\]`)
	return re.MatchString(text)
}

func SplitLogLine(text string) []string {
	re := regexp.MustCompile(`<[-~*=]*>`)
	return re.Split(text, -1)
}

func CountQuotedPasswords(lines []string) int {
	re := regexp.MustCompile(`(?i)".*password.*"`)
	ct := 0
	for _, line := range lines {
		if re.MatchString(line) {
			ct += 1
		}
	}
	return ct
}

func RemoveEndOfLineText(text string) string {
	re := regexp.MustCompile(`end-of-line[^ ]*`)
	return re.ReplaceAllString(text, "")
}

func TagWithUserName(lines []string) []string {
	re := regexp.MustCompile(`User\s+(\w+)`)
	arr := make([]string, len(lines))
	for i, line := range lines {
		match := re.FindStringSubmatch(line)
		if match != nil {
			arr[i] = fmt.Sprintf("[USR] %s %s", match[1], line)
		} else {
			arr[i] = line
		}
	}
	return arr
}
