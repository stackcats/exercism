package sublist

import "reflect"

func check(l1, l2 []int) bool {
	if len(l1) == 0 {
		return true
	}

	for i := 0; i < len(l2)-len(l1)+1; i++ {
		if reflect.DeepEqual(l2[i:i+len(l1)], l1) {
			return true
		}
	}

	return false
}

func Sublist(l1, l2 []int) Relation {
	c1 := check(l1, l2)
	c2 := check(l2, l1)
	if c1 && c2 {
		return RelationEqual
	}
	if c1 {
		return RelationSublist
	}
	if c2 {
		return RelationSuperlist
	}
	return RelationUnequal
}
