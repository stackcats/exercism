package armstrong

import "math"

func IsNumber(n int) bool {
	ct := 0.0
	for m := n; m > 0; m /= 10 {
		ct++
	}
	sum := 0.0
	for m := n; m > 0; m /= 10 {
		sum += math.Pow(float64(m%10), ct)
	}
	return int(sum) == n
}
