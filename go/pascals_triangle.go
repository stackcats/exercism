package pascal

func Triangle(n int) [][]int {
	arr := [][]int{{1}}
	if n == 1 {
		return arr
	}
	for n > 1 {
		n--
		row := []int{1}
		for i := 1; i < len(arr[len(arr)-1]); i++ {
			row = append(row, arr[len(arr)-1][i]+arr[len(arr)-1][i-1])
		}
		row = append(row, 1)
		arr = append(arr, row)
	}
	return arr
}
