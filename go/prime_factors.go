package prime

func Factors(n int64) []int64 {
	arr := []int64{}
	f := int64(2)
	for n >= f {
		if n%f == 0 {
			arr = append(arr, f)
			n /= f
		} else {
			f++
		}
	}
	return arr
}
