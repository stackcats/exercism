package grains

import (
	"errors"
	"math"
)

// Square calculate how many grains on the nth square
func Square(n int) (uint64, error) {
	if n <= 0 || n > 64 {
		return 0, errors.New("n must bettwen 0 and 64")
	}

	return uint64(math.Pow(2, float64(n-1))), nil
}

// Total number of grains
func Total() (tot uint64) {
	for i := 1; i <= 64; i++ {
		s, _ := Square(i)
		tot += s
	}
	return
}
