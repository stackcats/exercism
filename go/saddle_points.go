package matrix

import (
	"errors"
	"slices"
	"strconv"
	"strings"
)

// Define the Matrix and Pair types here.
type Pair [2]int

type Matrix [][]int

func New(s string) (*Matrix, error) {
	arr := strings.Split(s, "\n")
	mat := Matrix{}
	for i, line := range arr {
		row := strings.Split(line, " ")
		row = slices.DeleteFunc(row, func(n string) bool {
			return n == ""
		})
		if i > 0 && len(row) != len(mat[len(mat)-1]) {
			return nil, errors.New("len invalid")
		}
		ar := make([]int, len(row))
		for i, r := range row {
			n, err := strconv.Atoi(r)
			if err != nil {
				return nil, errors.New("invalid")
			}
			ar[i] = n
		}
		mat = append(mat, ar)
	}
	return &mat, nil
}

func (m *Matrix) Saddle() []Pair {
	mat := *m
	if len(mat) == 0 || len(mat[0]) == 0 {
		return []Pair{}
	}

	lmp := map[Pair]bool{}
	for i, row := range mat {
		largest := row[0]
		for j := 1; j < len(row); j++ {
			if row[j] > largest {
				largest = row[j]
			}
		}
		for j := 0; j < len(row); j++ {
			if row[j] == largest {
				lmp[Pair{i + 1, j + 1}] = true
			}
		}
	}

	smp := map[Pair]bool{}
	for j := 0; j < len(mat[0]); j++ {
		smallest := mat[0][j]
		for i := 1; i < len(mat); i++ {
			if mat[i][j] < smallest {
				smallest = mat[i][j]
			}
		}
		for i := 0; i < len(mat); i++ {
			if mat[i][j] == smallest {
				smp[Pair{i + 1, j + 1}] = true
			}
		}
	}

	ps := []Pair{}
	for k := range lmp {
		if smp[k] {
			ps = append(ps, k)
		}
	}

	return ps
}
