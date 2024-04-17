package foodchain

import (
	"fmt"
	"strings"
)

var foods = []string{"fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse"}

func Verse(v int) string {
	v--
	b := strings.Builder{}
	b.WriteString(fmt.Sprintf("I know an old lady who swallowed a %s.\n", foods[v]))

	snd := ""
	switch foods[v] {
	case "spider":
		snd = "It wriggled and jiggled and tickled inside her.\n"
	case "bird":
		snd = "How absurd to swallow a bird!\n"
	case "cat":
		snd = "Imagine that, to swallow a cat!\n"
	case "dog":
		snd = "What a hog, to swallow a dog!\n"
	case "goat":
		snd = "Just opened her throat and swallowed a goat!\n"
	case "cow":
		snd = "I don't know how she swallowed a cow!\n"
	case "horse":
		snd = "She's dead, of course!"
	}

	b.WriteString(snd)

	if foods[v] == "horse" {
		return b.String()
	}

	for v > 0 {
		if foods[v-1] == "spider" {
			b.WriteString(fmt.Sprintf("She swallowed the %s to catch the %s that wriggled and jiggled and tickled inside her.\n", foods[v], foods[v-1]))
		} else {
			b.WriteString(fmt.Sprintf("She swallowed the %s to catch the %s.\n", foods[v], foods[v-1]))
		}

		v--
	}

	b.WriteString(fmt.Sprintf("I don't know why she swallowed the %s. Perhaps she'll die.", foods[v]))

	return b.String()
}

func Verses(start, end int) string {
	b := strings.Builder{}
	for i := start; i <= end; i++ {
		if b.Len() > 0 {
			b.WriteString("\n\n")
		}
		b.WriteString(Verse(i))
	}
	return b.String()
}

func Song() string {
	return Verses(1, len(foods))
}
