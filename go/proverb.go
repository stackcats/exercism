package proverb

import "fmt"

func Proverb(rhyme []string) []string {
	if len(rhyme) == 0 {
		return []string{}
	}

	arr := make([]string, len(rhyme))
	for i := 1; i < len(rhyme); i++ {
		arr[i-1] = fmt.Sprintf("For want of a %s the %s was lost.", rhyme[i-1], rhyme[i])
	}

	arr[len(arr)-1] = fmt.Sprintf("And all for the want of a %s.", rhyme[0])

	return arr
}
