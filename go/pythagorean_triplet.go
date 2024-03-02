package pythagorean

type Triplet [3]int

// Range generates list of all Pythagorean triplets with side lengths
// in the provided range.
func Range(min, max int) []Triplet {
	arr := []Triplet{}
	for a := min; a <= max; a++ {
		for b := a + 1; b <= max; b++ {
			for c := b + 1; c <= max; c++ {
				if a*a+b*b == c*c {
					arr = append(arr, Triplet{a, b, c})
				}
			}
		}
	}
	return arr
}

// Sum returns a list of all Pythagorean triplets with a certain perimeter.
func Sum(p int) []Triplet {
	arr := Range(1, p)
	brr := []Triplet{}
	for _, each := range arr {
		if each[0]+each[1]+each[2] == p {
			brr = append(brr, each)
		}
	}
	return brr
}
