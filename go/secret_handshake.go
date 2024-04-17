package secret

import (
	"slices"
)

func Handshake(code uint) []string {
	actions := []string{"wink", "double blink", "close your eyes", "jump"}

	arr := []string{}
	for i, action := range actions {
		if code&uint(1<<i) != 0 {
			arr = append(arr, action)
		}
	}

	if code&uint(1<<4) != 0 {
		slices.Reverse(arr)
	}

	return arr
}
