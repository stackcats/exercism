package resistorcolortrio

import (
    "fmt"
)

var colorMap = map[string]int {
    "black": 0,
    "brown": 1,
	"red": 2,
	"orange": 3,
	"yellow": 4,
	"green": 5,
	"blue": 6,
	"violet": 7,
	"grey": 8,
	"white": 9,
}

// Label describes the resistance value given the colors of a resistor.
// The label is a string with a resistance value with an unit appended
// (e.g. "33 ohms", "470 kiloohms").
func Label(colors []string) string {
	amount := colorMap[colors[0]] * 10 + colorMap[colors[1]]
    zeros := colorMap[colors[2]]
    for zeros > 0 {
        zeros--
        amount *= 10
    }

    magnitude := []string{"ohms", "kiloohms", "megaohms", "gigaohms"}

    i := 0
    for i < len(magnitude) && amount > 0 && amount % 1000 == 0 {
        i++
        amount /= 1000
    }

    return fmt.Sprintf("%d %s", amount, magnitude[i])
}

