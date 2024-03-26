package railfence

func Encode(message string, rails int) string {
	mp := mapping(len(message), rails)
	s := make([]byte, len(message))
	for k, v := range mp {
		s[k] = message[v]
	}
	return string(s)
}

func Decode(message string, rails int) string {
	mp := mapping(len(message), rails)
	s := make([]byte, len(message))
	for k, v := range mp {
		s[v] = message[k]
	}
	return string(s)
}

func mapping(n, rails int) []int {
	arr := make([][]int, rails)
	j := 0
	dj := 1
	for i := 0; i < n; i++ {
		if arr[j] == nil {
			arr[j] = []int{}
		}
		arr[j] = append(arr[j], i)
		j += dj
		if j == 0 || j == rails-1 {
			dj = -dj
		}
	}
	res := []int{}
	for _, each := range arr {
		res = append(res, each...)
	}
	return res
}
