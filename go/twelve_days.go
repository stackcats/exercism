package twelve

import (
	"fmt"
	"strings"
)

var mp = [][]string{
	{"first", "a Partridge"},
	{"second", "two Turtle Doves"},
	{"third", "three French Hens"},
	{"fourth", "four Calling Birds"},
	{"fifth", "five Gold Rings"},
	{"sixth", "six Geese-a-Laying"},
	{"seventh", "seven Swans-a-Swimming"},
	{"eighth", "eight Maids-a-Milking"},
	{"ninth", "nine Ladies Dancing"},
	{"tenth", "ten Lords-a-Leaping"},
	{"eleventh", "eleven Pipers Piping"},
	{"twelfth", "twelve Drummers Drumming"},
}

func Verse(i int) string {
	gifts := []string{}
	for j := i - 1; j >= 0; j-- {
		if len(gifts) > 0 && j == 0 {
			gifts = append(gifts, "and "+mp[j][1])
		} else {
			gifts = append(gifts, mp[j][1])
		}
	}
	return fmt.Sprintf("On the %s day of Christmas my true love gave to me: %s in a Pear Tree.", mp[i-1][0], strings.Join(gifts, ", "))
}

func Song() string {
	lyrics := []string{}
	for i := 1; i <= len(mp); i++ {
		lyrics = append(lyrics, Verse(i))
	}
	return strings.Join(lyrics, "\n")
}
