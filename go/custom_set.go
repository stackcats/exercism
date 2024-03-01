package stringset

import "strings"

// Implement Set as a collection of unique string values.
//
// For Set.String, use '{' and '}', output elements as double-quoted strings
// safely escaped with Go syntax, and use a comma and a single space between
// elements. For example, a set with 2 elements, "a" and "b", should be formatted as {"a", "b"}.
// Format the empty set as {}.

// Define the Set type here.
type Set map[string]bool

func New() Set {
	return Set{}
}

func NewFromSlice(l []string) Set {
	st := New()
	for _, v := range l {
		st.Add(v)
	}
	return st
}

func (s Set) String() string {
	arr := []string{}
	for k := range s {
		arr = append(arr, `"`+k+`"`)
	}
	return "{" + strings.Join(arr, ", ") + "}"
}

func (s Set) IsEmpty() bool {
	return len(s) == 0
}

func (s Set) Has(elem string) bool {
	_, ok := s[elem]
	return ok
}

func (s Set) Add(elem string) {
	s[elem] = true
}

func Subset(s1, s2 Set) bool {
	for k := range s1 {
		if _, ok := s2[k]; !ok {
			return false
		}
	}
	return true
}

func Disjoint(s1, s2 Set) bool {
	for k := range s1 {
		if _, ok := s2[k]; ok {
			return false
		}
	}
	return true
}

func Equal(s1, s2 Set) bool {
	return Subset(s1, s2) && Subset(s2, s1)
}

func Intersection(s1, s2 Set) Set {
	st := New()
	for k := range s1 {
		if _, ok := s2[k]; ok {
			st.Add(k)
		}
	}
	return st
}

func Difference(s1, s2 Set) Set {
	st := New()
	for k := range s1 {
		if _, ok := s2[k]; !ok {
			st.Add(k)
		}
	}
	return st
}

func Union(s1, s2 Set) Set {
	st := New()
	for k := range s1 {
		st.Add(k)
	}
	for k := range s2 {
		st.Add(k)
	}
	return st
}
