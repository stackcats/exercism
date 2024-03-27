package ocr

import (
	"strings"
)

var nums = map[string]string{
	" _ | ||_|": "0",
	"     |  |": "1",
	" _  _||_ ": "2",
	" _  _| _|": "3",
	"   |_|  |": "4",
	" _ |_  _|": "5",
	" _ |_ |_|": "6",
	" _   |  |": "7",
	" _ |_||_|": "8",
	" _ |_| _|": "9",
}

func recognizeDigit(s string) string {
	t := nums[s]
	if t == "" {
		return "?"
	}
	return t
}

func Recognize(s string) []string {
	arr := strings.Split(s, "\n")

	res := []string{}
	for i := 1; i < len(arr); i += 4 {
		s := ""
		for j := 0; j < len(arr[i+1]); j += 3 {
			s += recognizeDigit(arr[i][j:j+3] + arr[i+1][j:j+3] + arr[i+2][j:j+3])
		}
		res = append(res, s)
	}

	return res
}
