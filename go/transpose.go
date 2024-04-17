package transpose

import (
	"fmt"
	"slices"
	"strings"
)

func Transpose(input []string) []string {
	maxLen := 0
	for _, s := range input {
		maxLen = slices.Max([]int{maxLen, len(s)})
	}

	mat := make([][]rune, maxLen)
	for i := 0; i < maxLen; i++ {
		mat[i] = make([]rune, len(input))
		for j := 0; j < len(input); j++ {
			mat[i][j] = ' '
		}
	}

	for i, s := range input {
		for j, c := range s {
			mat[j][i] = c
		}
	}

	trans := make([]string, maxLen)
	pad := 0
	for i := maxLen - 1; i >= 0; i-- {
		s := strings.TrimRight(string(mat[i]), " ")
		f := fmt.Sprintf("%%-%ds", pad)
		s = fmt.Sprintf(f, s)
		trans[i] = s
		pad = slices.Max([]int{pad, len(s)})
	}

	return trans
}
