package lsproduct

import (
	"errors"
	"unicode"
)

func product(digits string) (int64, error) {
	var ans int64 = 1
	for _, c := range digits {
		if !unicode.IsDigit(c) {
			return 0, errors.New("digits input must only contain digits")
		}
		ans *= int64(c - '0')
	}
	return ans, nil
}

func LargestSeriesProduct(digits string, span int) (int64, error) {
	if span > len(digits) {
		return 0, errors.New("span must be smaller than string length")
	}
	if span < 0 {
		return 0, errors.New("span must not be negative")
	}

	var ans int64 = 0
	for i := 0; i < len(digits)-span+1; i++ {
		n, err := product(digits[i : i+span])
		if err != nil {
			return 0, err
		}
		if ans < n {
			ans = n
		}
	}
	return ans, nil
}
