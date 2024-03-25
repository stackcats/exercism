package bookstore

func Cost(books []int) int {
	arr := make([]int, 6)
	for _, book := range books {
		arr[book-1]++
	}

	groups := make([]int, 6)

	for {
		ct := 0
		for i, v := range arr {
			if v > 0 {
				ct++
				arr[i]--
			}
		}
		if ct == 0 {
			break
		}
		groups[ct]++
	}

	for groups[3] > 0 && groups[5] > 0 {
		groups[3]--
		groups[5]--
		groups[4] += 2
	}

	discounts := []float64{0, 0, 0.05, 0.1, 0.2, 0.25}

	s := 0
	for i, v := range groups {
		s += i * v * int(800*(1-discounts[i]))
	}
	return s
}

