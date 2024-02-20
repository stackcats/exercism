package darts

import "math"

func Score(x, y float64) int {
	dis := math.Sqrt(x*x + y*y)
	if dis > 10 {
		return 0
	}
	if dis > 5 {
		return 1
	}
	if dis > 1 {
		return 5
	}
	return 10
}
