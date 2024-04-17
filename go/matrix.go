package matrix

import (
	"errors"
	"strconv"
	"strings"
)

// Define the Matrix type here.
type Matrix [][]int

func New(s string) (Matrix, error) {
	arr := strings.Split(s, "\n")
	m := make([][]int, len(arr))
	for i, line := range arr {
		row := strings.Split(line, " ")
		m[i] = []int{}
		for _, each := range row {
			if each == "" {
				continue
			}
			n, err := strconv.Atoi(each)
			if err != nil {
				return m, errors.New("invalid")
			}
			m[i] = append(m[i], n)
		}
		if i > 0 && len(m[i]) != len(m[i-1]) {
			return m, errors.New("invalid")
		}
	}
	return m, nil
}

// Cols and Rows must return the results without affecting the matrix.
func (m Matrix) Cols() [][]int {
	if len(m) == 0 {
		return [][]int{}
	}

	cs := make([][]int, len(m[0]))
	for j := 0; j < len(m[0]); j++ {
		cs[j] = make([]int, len(m))
		for i := 0; i < len(m); i++ {
			cs[j][i] = m[i][j]
		}
	}
	return cs
}

func (m Matrix) Rows() [][]int {
	rs := make([][]int, len(m))
	for i, row := range m {
		rs[i] = append([]int{}, row...)
	}
	return rs
}

func (m Matrix) Set(row, col, val int) bool {
	if row >= 0 && row < len(m) && col >= 0 && col < len(m[0]) {
		m[row][col] = val
		return true
	}
	return false
}
