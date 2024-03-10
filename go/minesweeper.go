package minesweeper

import "fmt"

// Annotate returns an annotated board
func Annotate(board []string) []string {
	dirs := [][]int{
		{-1, -1},
		{-1, 0},
		{-1, 1},
		{0, 1},
		{1, 1},
		{1, 0},
		{1, -1},
		{0, -1},
	}

	annotated := make([]string, len(board))
	for i, line := range board {
		for j, c := range line {
			if c == '*' {
				annotated[i] += "*"
				continue
			}
			ct := 0
			for _, d := range dirs {
				ni, nj := i+d[0], j+d[1]
				if ni >= 0 && ni < len(board) && nj >= 0 && nj < len(line) && board[ni][nj] == '*' {
					ct++
				}
			}
			if ct == 0 {
				annotated[i] += " "
			} else {
				annotated[i] += fmt.Sprintf("%d", ct)
			}
		}
	}
	return annotated
}
