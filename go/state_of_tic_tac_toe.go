package stateoftictactoe

import (
	"errors"
)

type State string

const (
	Win     State = "win"
	Ongoing State = "ongoing"
	Draw    State = "draw"
)

func StateOfTicTacToe(board []string) (State, error) {
	xs, os := 0, 0
	finished := true
	for _, row := range board {
		for _, c := range row {
			if c == 'X' {
				xs++
			} else if c == 'O' {
				os++
			} else {
				finished = false
			}
		}
	}

	diff := xs - os
	if !(diff >= 0 && diff <= 1) {
		return "", errors.New("invalid")
	}

	rules := [][][]int{
		{{0, 0}, {0, 1}, {0, 2}},
		{{1, 0}, {1, 1}, {1, 2}},
		{{2, 0}, {2, 1}, {2, 2}},
		{{0, 0}, {1, 0}, {2, 0}},
		{{0, 1}, {1, 1}, {2, 1}},
		{{0, 2}, {1, 2}, {2, 2}},
		{{0, 0}, {1, 1}, {2, 2}},
		{{0, 2}, {1, 1}, {2, 0}},
	}

	xwin := false
	owin := false

	for _, rule := range rules {
		mp := map[byte]int{}
		for _, pos := range rule {
			mp[board[pos[0]][pos[1]]]++
		}
		if mp['X'] == 3 {
			xwin = true
		} else if mp['O'] == 3 {
			owin = true
		}
	}

	if xwin && owin {
		return "", errors.New("invalid")
	}

	if xwin || owin {
		return Win, nil
	}

	if !finished {
		return Ongoing, nil
	}

	return Draw, nil
}
