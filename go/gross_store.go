package gross

func Units() map[string]int {
	return map[string]int{
		"quarter_of_a_dozen": 3,
		"half_of_a_dozen":    6,
		"dozen":              12,
		"small_gross":        120,
		"gross":              144,
		"great_gross":        1728,
	}
}

func NewBill() map[string]int {
	return map[string]int{}
}

func AddItem(bill, units map[string]int, item, unit string) bool {
	if v, ok := units[unit]; ok {
		bill[item] += v
		return true
	}
	return false
}

func RemoveItem(bill, units map[string]int, item, unit string) bool {
	v, ok := units[unit]
	if !ok {
		return false
	}
	t, ok := bill[item]
	if !ok {
		return false
	}
	diff := t - v
	if diff < 0 {
		return false
	}
	if diff == 0 {
		delete(bill, item)
		return true
	}
	bill[item] = diff
	return true
}

func GetItem(bill map[string]int, item string) (int, bool) {
	v, ok := bill[item]
	return v, ok
}
