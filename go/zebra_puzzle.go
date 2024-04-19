package zebra

const (
	houseCount    = 5
	propertyCount = 5
)

var nationalities = []string{
	"Englishman",
	"Spaniard",
	"Ukrainian",
	"Norwegian",
	"Japanese",
}

const (
	_ = iota
	Englishman
	Spaniard
	Ukrainian
	Norwegian
	Japanese
)

const (
	_ = iota
	red
	green
	ivory
	yellow
	blue
)

const (
	_ = iota
	coffee
	tea
	milk
	juice
	water
)

const (
	_ = iota
	dog
	snails
	fox
	horse
	zebra
)

const (
	_ = iota
	OldGold
	Kools
	Chesterfields
	LuckyStrike
	Parliaments
)

const (
	color = iota
	pet
	beverage
	cigaret
	nationality
)

var s = [houseCount][propertyCount]int{}

func nextTo(h, p, v int) bool {
	return (h > 0 && (s[h-1][p] == 0 || s[h-1][p] == v)) || (h < houseCount-1 && (s[h+1][p] == 0 || s[h+1][p] == v))
}

func check() bool {
	for i := 0; i < houseCount; i++ {
		for j := i + 1; j < houseCount; j++ {
			for k := 0; k < propertyCount; k++ {
				if s[i][k] != 0 && s[j][k] != 0 && s[i][k] == s[j][k] {
					return false
				}
			}
		}
	}

	for i := 0; i < houseCount; i++ {
		// The Englishman lives in the red house.
		if s[i][nationality] == Englishman && s[i][color] != 0 && s[i][color] != red {
			return false
		}

		// The Spaniard owns the dog.
		if s[i][nationality] == Spaniard && s[i][pet] != 0 && s[i][pet] != dog {
			return false
		}

		// Coffee is drunk in the green house.
		if s[i][beverage] == coffee && s[i][color] != 0 && s[i][color] != green {
			return false
		}

		// The Ukrainian drinks tea.
		if s[i][nationality] == Ukrainian && s[i][beverage] != 0 && s[i][beverage] != tea {
			return false
		}

		// The green house is immediately to the right of the ivory house.
		if i == 0 && s[i][color] == green {
			// The green house can't be the first one
			return false
		} else if i > 0 && s[i][color] == green && s[i-1][color] != 0 && s[i-1][color] != ivory {
			return false
		}

		// The Old Gold smoker owns snails.
		if s[i][cigaret] == OldGold && s[i][pet] != 0 && s[i][pet] != snails {
			return false
		}

		// Kools are smoked in the yellow house.
		if s[i][cigaret] == Kools && s[i][color] != 0 && s[i][color] != yellow {
			return false
		}

		// Milk is drunk in the middle house.
		if s[i][beverage] == milk && i != houseCount/2 {
			return false
		}

		// The Norwegian lives in the first house.
		if s[i][nationality] == Norwegian && i != 0 {
			return false
		}

		// The man who smokes Chesterfields lives in the house next to the man with the fox.
		if s[i][cigaret] == Chesterfields && !nextTo(i, pet, fox) {
			return false
		}

		// Kools are smoked in the house next to the house where the horse is kept.
		if s[i][cigaret] == Kools && !nextTo(i, pet, horse) {
			return false
		}

		// The Lucky Strike smoker drinks orange juice.
		if s[i][cigaret] == LuckyStrike && s[i][beverage] != 0 && s[i][beverage] != juice {
			return false
		}

		// The Japanese smokes Parliaments.
		if s[i][nationality] == Japanese && s[i][cigaret] != 0 && s[i][cigaret] != Parliaments {
			return false
		}

		// The Norwegian lives next to the blue house.
		if s[i][nationality] == Norwegian && !nextTo(i, color, blue) {
			return false
		}
	}

	return true
}

func findSolution(house, property int) bool {
	v := s[house][property]

	nextHouse := (house + 1) % houseCount
	nextProperty := property
	if nextHouse == 0 {
		nextProperty++
	}

	for i := 1; i <= 5; i++ {
		s[house][property] = i
		if check() {
			if nextProperty >= propertyCount || findSolution(nextHouse, nextProperty) {
				return true
			}
		}
	}
	s[house][property] = v
	return false
}

type Solution struct {
	DrinksWater string
	OwnsZebra   string
}

func SolvePuzzle() Solution {
	findSolution(0, 0)

	sol := Solution{}

	for _, h := range s {
		if h[beverage] == water {
			sol.DrinksWater = nationalities[h[nationality]-1]
		}
		if h[pet] == zebra {
			sol.OwnsZebra = nationalities[h[nationality]-1]
		}
	}

	return sol
}
