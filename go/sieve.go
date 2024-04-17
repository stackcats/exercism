package sieve

func Sieve(limit int) []int {
	if limit < 2 {
		return []int{}
	}

	arr := make([]int, limit+1)

	ans := []int{2}

	for i := 3; i <= limit; i += 2 {
		if arr[i] == 0 {
			ans = append(ans, i)
		}
		for k := i * i; k <= limit; k += i {
			arr[k] = 1
		}
	}
	return ans
}
