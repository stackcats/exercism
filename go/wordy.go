package wordy

import (
	"strconv"
	"strings"
)

func Answer(question string) (int, bool) {
	question = strings.Trim(question, "?What is")
	question = strings.ReplaceAll(question, "multiplied by", "multiplied")
	question = strings.ReplaceAll(question, "divided by", "divided")
	arr := strings.Split(question, " ")
	if len(arr) == 0 || len(arr)%2 == 0 {
		return 0, false
	}
	ans, err := strconv.Atoi(arr[0])
	if err != nil {
		return 0, false
	}

	for i := 1; i < len(arr); i += 2 {
		n, err := strconv.Atoi(arr[i+1])
		if err != nil {
			return 0, false
		}
		switch arr[i] {
		case "plus":
			ans += n
		case "minus":
			ans -= n
		case "divided":
			ans /= n
		case "multiplied":
			ans *= n
		default:
			return 0, false
		}
	}
	return ans, true
}
