package listops

// IntList is an abstraction of a list of integers which we can define methods on
type IntList []int

func (s IntList) Foldl(fn func(int, int) int, initial int) int {
	for _, v := range s {
		initial = fn(initial, v)
	}
	return initial
}

func (s IntList) Foldr(fn func(int, int) int, initial int) int {
	for i := len(s) - 1; i >= 0; i-- {
		initial = fn(s[i], initial)
	}
	return initial
}

func (s IntList) Filter(fn func(int) bool) IntList {
	arr := []int{}
	for _, v := range s {
		if fn(v) {
			arr = append(arr, v)
		}
	}
	return arr
}

func (s IntList) Length() int {
	return len(s)
}

func (s IntList) Map(fn func(int) int) IntList {
	arr := []int{}
	for _, v := range s {
		arr = append(arr, fn(v))
	}
	return arr
}

func (s IntList) Reverse() IntList {
	arr := make([]int, s.Length())
	for i := 0; i < s.Length(); i++ {
		arr[s.Length()-1-i] = s[i]
	}
	return arr
}

func (s IntList) Append(lst IntList) IntList {
	return append(s, lst...)
}

func (s IntList) Concat(lists []IntList) IntList {
	for _, v := range lists {
		s = s.Append(v)
	}
	return s
}
