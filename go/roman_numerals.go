package romannumerals

import "errors"

type Pair struct {
	a string
	b int
}

func ToRomanNumeral(input int) (string, error) {
	if input <= 0 || input >= 4000 {
		return "", errors.New("overflow")
	}

	romans := []Pair{
		{"M", 1000},
		{"CM", 900},
		{"D", 500},
		{"CD", 400},
		{"C", 100},
		{"XC", 90},
		{"L", 50},
		{"XL", 40},
		{"X", 10},
		{"IX", 9},
		{"V", 5},
		{"IV", 4},
		{"I", 1},
	}

	s := ""
	for _, pair := range romans {
		for input >= pair.b {
			s += pair.a
			input -= pair.b
		}
	}
	return s, nil
}
