package bowling

import (
	"errors"
)

var (
	ErrRollNegative   = errors.New("Negative roll is invalid")
	ErrRollExceedPins = errors.New("Pin count exceeds pins on the lane")
	ErrRollGameOver   = errors.New("Cannot roll after game is over")
	ErrCannotScore    = errors.New("cannot scored")
)

// Define the Game type here.
type Game struct {
	rolls []int
}

func NewGame() *Game {
	return &Game{}
}

func (g *Game) Roll(pins int) error {
	if pins < 0 {
		return ErrRollNegative
	}

	if pins > 10 {
		return ErrRollExceedPins
	}

	if len(g.rolls) == 20 {
		if g.rolls[18]+g.rolls[19] != 10 {
			return ErrRollGameOver
		}
	}

	if len(g.rolls) == 21 {
		if g.rolls[18] != 10 {
			return ErrRollGameOver
		}
		if g.rolls[20] != 10 && g.rolls[20]+pins > 10 {
			return ErrRollExceedPins
		}
	}

	if len(g.rolls) == 22 {
		return ErrRollGameOver
	}

	if len(g.rolls) < 20 && len(g.rolls)%2 == 1 && pins+g.rolls[len(g.rolls)-1] > 10 {
		return ErrRollExceedPins
	}

	if pins == 10 {
		g.rolls = append(g.rolls, 10)
		if len(g.rolls) < 20 {
			g.rolls = append(g.rolls, 0)
		}
	} else {
		g.rolls = append(g.rolls, pins)
	}
	return nil
}

func (g *Game) Score() (int, error) {
	if len(g.rolls) < 20 || g.rolls[18] == 10 && len(g.rolls) != 22 || g.rolls[18] != 10 && g.rolls[18]+g.rolls[19] == 10 && len(g.rolls) != 21 {
		return 0, ErrCannotScore
	}

	s := 0
	for i := 0; i < 20; i += 2 {
		if g.rolls[i] == 10 {
			s += 10
			if g.rolls[i+2] == 10 {
				if i == 18 {
					s += g.rolls[i+2] + g.rolls[i+3]
				} else {
					s += 10 + g.rolls[i+4]
				}
			} else {
				s += g.rolls[i+2] + g.rolls[i+3]
			}
		} else if g.rolls[i]+g.rolls[i+1] == 10 {
			s += 10 + g.rolls[i+2]
		} else {
			s += g.rolls[i] + g.rolls[i+1]
		}
	}

	return s, nil
}

