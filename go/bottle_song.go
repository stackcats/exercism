package bottlesong

import (
	"fmt"
	"strings"
)

var nums = []string{"no", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"}

func aux(n int) string {
	if n == 1 {
		return "bottle"
	}
	return "bottles"
}

func verses(n int) []string {
	first := fmt.Sprintf("%s green %s hanging on the wall,", nums[n], aux(n))
	first = strings.ToUpper(first[:1]) + first[1:]
	verse := []string{
		first,
		first,
		"And if one green bottle should accidentally fall,",
		fmt.Sprintf("There'll be %s green %s hanging on the wall.", nums[n-1], aux(n-1)),
	}
	return verse
}

func Recite(startBottles, takeDown int) []string {
	arr := []string{}
	for i := 0; i < takeDown; i++ {
		if len(arr) > 0 {
			arr = append(arr, "")
		}
		arr = append(arr, verses(startBottles)...)
		startBottles--
	}
	return arr
}
