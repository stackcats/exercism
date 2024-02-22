package triangle

type Kind int

const (
	NaT = iota
	Equ
	Iso
	Sca
)

func isValid(a, b, c float64) bool {
	return a > 0 && b > 0 && c > 0 && a+b >= c && b+c >= a && a+c >= b
}

func KindFromSides(a, b, c float64) Kind {
	if !isValid(a, b, c) {
		return NaT
	}

	if a == b && b == c {
		return Equ
	}

	if a == b || b == c || a == c {
		return Iso
	}

	return Sca
}
