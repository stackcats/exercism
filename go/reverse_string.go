package reverse

func Reverse(s string) string {
	arr := []rune(s)

	i := 0
	j := len(arr) - 1
	for i < j {
		arr[i], arr[j] = arr[j], arr[i]
		i++
		j--
	}

	return string(arr)
}
