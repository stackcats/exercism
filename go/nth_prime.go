package prime

import (
	"errors"
	"math"
)

// Nth returns the nth prime number. An error must be returned if the nth prime number can't be calculated ('n' is equal or less than zero)
func Nth(n int) (int, error) {
	if n <= 0 {
		return 0, errors.New("there is no zeroth prime")
	}

	p := 1
	for i := 0; i < n; i++ {
		p++
		for !isPrime(p) {
			p++
		}
	}
	return p, nil
}

func isPrime(n int) bool {
	if n < 2 {
		return false
	}

	if n == 2 {
		return true
	}

	end := int(math.Sqrt(float64(n)) + 1)
	for i := 2; i < end; i++ {
		if n%i == 0 {
			return false
		}
	}

	return true
}
