package allyourbase

import (
	"errors"
	"slices"
)

func ConvertToBase(inputBase int, inputDigits []int, outputBase int) ([]int, error) {
	if inputBase < 2 {
		return nil, errors.New("input base must be >= 2")
	}

	if outputBase < 2 {
		return nil, errors.New("output base must be >= 2")
	}

	n := 0
	for _, d := range inputDigits {
		if d < 0 || d >= inputBase {
			return nil, errors.New("all digits must satisfy 0 <= d < input base")
		}
		n = n*inputBase + d
	}

	if n == 0 {
		return []int{0}, nil
	}

	arr := []int{}

	for ; n > 0; n /= outputBase {
		arr = append(arr, n%outputBase)
	}

	slices.Reverse(arr)

	return arr, nil
}
