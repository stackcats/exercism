package complexnumbers

import "math"

type Number struct {
	real float64
	imag float64
}

func (n Number) Real() float64 {
	return n.real
}

func (n Number) Imaginary() float64 {
	return n.imag
}

func (n1 Number) Add(n2 Number) Number {
	return Number{
		n1.real + n2.real,
		n1.imag + n2.imag,
	}
}

func (n1 Number) Subtract(n2 Number) Number {
	return Number{
		n1.real - n2.real,
		n1.imag - n2.imag,
	}
}

func (n1 Number) Multiply(n2 Number) Number {
	return Number{
		n1.real*n2.real - n1.imag*n2.imag,
		n1.imag*n2.real + n1.real*n2.imag,
	}
}

func (n Number) Times(factor float64) Number {
	return Number{
		n.real * factor,
		n.imag * factor,
	}
}

func (n1 Number) Divide(n2 Number) Number {
	d := n2.real*n2.real + n2.imag*n2.imag
	return Number{
		(n1.real*n2.real + n1.imag*n2.imag) / d,
		(n1.imag*n2.real - n1.real*n2.imag) / d,
	}
}

func (n Number) Conjugate() Number {
	return Number{
		n.real,
		-n.imag,
	}
}

func (n Number) Abs() float64 {
	return math.Sqrt(n.real*n.real + n.imag*n.imag)
}

func (n Number) Exp() Number {
	ea := math.Exp(n.real)
	return Number{
		ea * math.Cos(n.imag),
		ea * math.Sin(n.imag),
	}
}
