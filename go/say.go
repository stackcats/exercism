package say

import (
	"slices"
	"strings"
)

var digits = []string{
	"zero",
	"one",
	"two",
	"three",
	"four",
	"five",
	"six",
	"seven",
	"eight",
	"nine",
	"ten",
	"eleven",
	"twelve",
	"thirteen",
	"fourteen",
	"fifteen",
	"sixteen",
	"seventeen",
	"eighteen",
	"nineteen",
}

var tens = []string{
	"",
	"",
	"twenty",
	"thirty",
	"forty",
	"fifty",
	"sixty",
	"seventy",
	"eighty",
	"ninety",
}

func Say(n int64) (string, bool) {
	if n < 0 || n >= 1000000000000 {
		return "", false
	}

	if n == 0 {
		return "zero", true
	}

	arr := []int{}
	for n > 0 {
		arr = append(arr, int(n%1000))
		n /= 1000
	}

	brr := []string{"thousand", "million", "billion"}
	res := []string{}
	for i, num := range arr {
		if num == 0 {
			continue
		}
		r := []string{}
		a := num / 100
		if a > 0 {
			r = append(r, digits[a], "hundred")
		}

		b := num / 10 % 10

		if b < 2 {
			c := num % 100
			if c != 0 {
				r = append(r, digits[c])
			}
		} else {
			c := num % 10
			if c == 0 {
				r = append(r, tens[b])
			} else {
				r = append(r, tens[b]+"-"+digits[c])
			}
		}

		if i > 0 {
			res = append(res, brr[i-1])
		}

		res = append(res, strings.Join(r, " "))
	}

	slices.Reverse(res)
	return strings.Join(res, " "), true
}
