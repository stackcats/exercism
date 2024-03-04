package binarysearch

func SearchInts(list []int, key int) int {
	i := 0
	j := len(list) - 1
	for i <= j {
		m := i + (j-i)/2
		if list[m] == key {
			return m
		}
		if list[m] < key {
			i = m + 1
		} else {
			j = m - 1
		}
	}
	return -1
}

