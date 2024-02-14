package collatzconjecture

import "errors"

// CollatzConjecture return the number of steps required to reach 1
func CollatzConjecture(n int) (int, error) {
	if n < 1 {
		return 0, errors.New("error")
	}

	step := 0
	for n != 1 {
		step++

		if n%2 == 0 {
			n /= 2
		} else {
			n = 3*n + 1
		}
	}

	return step, nil
}
