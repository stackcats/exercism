package school

import (
	"cmp"
	"slices"
)

// Define the Grade and School types here.
type School struct {
	students map[int][]string
}

type Grade struct {
	n     int
	names []string
}

func New() *School {
	return &School{
		students: make(map[int][]string),
	}
}

func (s *School) Add(student string, grade int) {
	s.students[grade] = append(s.students[grade], student)
	slices.Sort(s.students[grade])
}

func (s *School) Grade(level int) []string {
	return s.students[level]
}

func (s *School) Enrollment() []Grade {
	g := []Grade{}
	for k, v := range s.students {
		g = append(g, Grade{k, v})
	}
	slices.SortFunc(g, func(a, b Grade) int {
		return cmp.Compare(a.n, b.n)
	})

	return g
}
