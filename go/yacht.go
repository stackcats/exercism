package yacht

func Score(dice []int, category string) int {
	mp := map[int]int{}
	sum := 0
	for _, d := range dice {
		mp[d]++
		sum += d
	}

	switch category {
	case "yacht":
		for _, v := range mp {
			if v == 5 {
				return 50
			}
		}
		return 0
	case "ones":
		return mp[1]
	case "twos":
		return mp[2] * 2
	case "threes":
		return mp[3] * 3
	case "fours":
		return mp[4] * 4
	case "fives":
		return mp[5] * 5
	case "sixes":
		return mp[6] * 6
	case "full house":
		has3, has2 := false, false
		for _, v := range mp {
			if v == 3 {
				has3 = true
			} else if v == 2 {
				has2 = true
			}
		}
		if has3 && has2 {
			return sum
		}
		return 0
	case "four of a kind":
		for d, v := range mp {
			if v >= 4 {
				return d * 4
			}
		}
		return 0
	case "little straight":
		for _, v := range mp {
			if v != 1 {
				return 0
			}
		}
		if mp[1] == 1 && mp[6] == 0 {
			return 30
		}
		return 0
	case "big straight":
		for _, v := range mp {
			if v != 1 {
				return 0
			}
		}
		if mp[6] == 1 && mp[1] == 0 {
			return 30
		}
		return 0
	case "choice":
		return sum
	default:
		return 0
	}
}
