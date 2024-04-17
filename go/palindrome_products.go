package palindrome

import "errors"

// Define Product type here.
type Product struct {
	n              int
	Factorizations [][2]int
}

func rev(n int) int {
	r := 0
	for n > 0 {
		r = r*10 + n%10
		n /= 10
	}
	return r
}

func Products(fmin, fmax int) (Product, Product, error) {
	if fmin > fmax {
		return Product{}, Product{}, errors.New("fmin > fmax")
	}
	pmin := fmin*fmax + 1
	mins := [][2]int{}
	pmax := 0
	maxes := [][2]int{}

	for i := fmin; i <= fmax; i++ {
		for j := i; j <= fmax; j++ {
			r := rev(i * j)
			if r == i*j {
				if r < pmin {
					pmin = r
					mins = [][2]int{{i, j}}
				} else if r == pmin {
					mins = append(mins, [2]int{i, j})
				}
				if r > pmax {
					pmax = r
					maxes = [][2]int{{i, j}}
				} else if r == pmax {
					maxes = append(maxes, [2]int{i, j})
				}
			}
		}
	}
	if pmin > pmax {
		return Product{}, Product{}, errors.New("no palindromes")
	}
	return Product{pmin, mins}, Product{pmax, maxes}, nil
}
