package space

type Planet string

func Age(seconds float64, planet Planet) float64 {
	y := seconds / 31557600.0
	switch planet {
	case "Mercury":
		return y / 0.2408467
	case "Venus":
		return y / 0.61519726
	case "Earth":
		return y
	case "Mars":
		return y / 1.880815
	case "Jupiter":
		return y / 11.862615
	case "Saturn":
		return y / 29.447498
	case "Uranus":
		return y / 84.016846
	case "Neptune":
		return y / 164.79132
	}
	return -1
}
