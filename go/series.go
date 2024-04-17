package series

func All(n int, s string) []string {
	arr := []string{}
	for i := 0; i < len(s)-n+1; i++ {
		arr = append(arr, string(s[i:i+n]))
	}
	return arr
}

func UnsafeFirst(n int, s string) string {
	return All(n, s)[0]
}
