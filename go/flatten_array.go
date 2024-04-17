package flatten

func Flatten(nested interface{}) []interface{} {
	if nested == nil {
		return []interface{}{}
	}

	arr, ok := nested.([]interface{})
	if !ok {
		return []interface{}{nested}
	}

	res := []interface{}{}
	for _, n := range arr {
		res = append(res, Flatten(n)...)
	}
	return res
}
