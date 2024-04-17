package kindergarten

import (
	"errors"
	"regexp"
	"slices"
	"strings"
)

// Define the Garden type here.
type Garden struct {
	students map[string][]string
}

var plantMap = map[rune]string{
	'C': "clover",
	'R': "radishes",
	'V': "violets",
	'G': "grass",
}

// The diagram argument starts each row with a '\n'.  This allows Go's
// raw string literals to present diagrams in source code nicely as two
// rows flush left, for example,
//
//     diagram := `
//     VVCCGG
//     VVCCGG`

func NewGarden(diagram string, children []string) (*Garden, error) {
	re := regexp.MustCompile("^\n[VRGC]+\n[VRGC]+$")
	if !re.MatchString(diagram) {
		return nil, errors.New("invalid")
	}

	arr := strings.Split(diagram[1:], "\n")
	if len(arr[0]) != len(arr[1]) {
		return nil, errors.New("invalid")
	}

	if len(arr[0]) != len(children)*2 {
		return nil, errors.New("invalid")
	}

	g := Garden{
		students: map[string][]string{},
	}

	sorted := append([]string{}, children...)

	slices.Sort(sorted)

	for i, child := range sorted {
		if _, ok := g.students[child]; ok {
			return nil, errors.New("duplicate name")
		}
		plants := make([]string, 4)
		plants[0] = plantMap[rune(arr[0][i*2])]
		plants[1] = plantMap[rune(arr[0][i*2+1])]
		plants[2] = plantMap[rune(arr[1][i*2])]
		plants[3] = plantMap[rune(arr[1][i*2+1])]
		g.students[child] = plants
	}
	return &g, nil
}

func (g *Garden) Plants(child string) ([]string, bool) {
	plants, ok := g.students[child]
	return plants, ok
}
