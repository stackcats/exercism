package strain

func Keep[T any](s []T, fn func(T) bool) []T {
	t := []T{}
	for _, each := range s {
		if fn(each) {
			t = append(t, each)
		}
	}
	return t
}

func Discard[T any](s []T, fn func(T) bool) []T {
	t := []T{}
	for _, each := range s {
		if !fn(each) {
			t = append(t, each)
		}
	}
	return t
}
