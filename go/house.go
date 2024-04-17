package house

import (
	"fmt"
	"strings"
)

var nouns = []string{
	"house that Jack built.",
	"malt",
	"rat",
	"cat",
	"dog",
	"cow with the crumpled horn",
	"maiden all forlorn",
	"man all tattered and torn",
	"priest all shaven and shorn",
	"rooster that crowed in the morn",
	"farmer sowing his corn",
	"horse and the hound and the horn",
}

var verbs = []string{
	"lay in",
	"ate",
	"killed",
	"worried",
	"tossed",
	"milked",
	"kissed",
	"married",
	"woke",
	"kept",
	"belonged to",
}

func Verse(v int) string {
	s := strings.Builder{}
	for i := v - 1; i >= 0; i-- {
		if i == v-1 {
			s.WriteString(fmt.Sprintf("This is the %s", nouns[i]))
		} else {
			s.WriteString(fmt.Sprintf("that %s the %s", verbs[i], nouns[i]))
		}
		if i != 0 {
			s.WriteString("\n")
		}
	}
	return s.String()
}

func Song() string {
	s := strings.Builder{}
	for v := 1; v <= 12; v++ {
		s.WriteString(Verse(v))
		if v < 12 {
			s.WriteString("\n\n")
		}
	}
	return s.String()
}
