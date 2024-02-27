package resistorcolorduo

// Colors returns the list of all colors.
func Colors() []string {
	return []string{
		"black",
		"brown",
		"red",
		"orange",
		"yellow",
		"green",
		"blue",
		"violet",
		"grey",
		"white",
	}
}

// ColorCode returns the resistance value of the given color.
func ColorCode(color string) int {
	colors := Colors()
	for i, c := range colors {
		if c == color {
			return i
		}
	}
	return -1
}

// Value should return the resistance value of a resistor with a given colors.
func Value(colors []string) int {
	return ColorCode(colors[0])*10 + ColorCode(colors[1])
}
