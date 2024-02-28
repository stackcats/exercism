package cipher

import (
	"strings"
	"unicode"
)

// Define the shift and vigenere types here.
// Both types should satisfy the Cipher interface.

type caesar struct{}

func NewCaesar() Cipher {
	return NewShift(3)
}

type shift struct {
	distance int
}

func NewShift(distance int) Cipher {
	if distance == -3 {
		return shift{
			distance: distance,
		}
	}

	if distance <= 0 || distance >= 26 {
		return nil
	}

	return shift{
		distance: distance,
	}
}

func (c shift) Encode(input string) string {
	output := []rune{}
	for _, ch := range input {
		if !unicode.IsLetter(ch) {
			continue
		}
		output = append(output, 'a'+(unicode.ToLower(ch)+rune(c.distance)-'a'+26)%26)
	}
	return string(output)
}

func (c shift) Decode(input string) string {
	output := []rune{}
	for _, ch := range input {
		output = append(output, 'a'+(ch-rune(c.distance)-'a'+26)%26)
	}
	return string(output)
}

type vigenere struct {
	key []rune
}

func NewVigenere(key string) Cipher {
	if key == "" {
		return nil
	}

	for _, c := range key {
		if !unicode.IsLower(c) {
			return nil
		}
	}

	if key == strings.Repeat("a", len(key)) {
		return nil
	}

	return vigenere{
		key: []rune(key),
	}
}

func (v vigenere) Encode(input string) string {
	output := []rune{}
	i := 0
	for _, ch := range input {
		if !unicode.IsLetter(ch) {
			continue
		}
		output = append(output, 'a'+(unicode.ToLower(ch)-'a'+v.key[i%len(v.key)]-'a'+26)%26)
		i++
	}
	return string(output)
}

func (v vigenere) Decode(input string) string {
	output := []rune{}
	for i, ch := range input {
		output = append(output, 'a'+(ch-'a'-(v.key[i%len(v.key)]-'a')+26)%26)
	}
	return string(output)
}
