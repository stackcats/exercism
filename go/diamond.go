package diamond

import (
	"errors"
	"strings"
)

func row(char byte, spacesLen int) string {
	spaces := strings.Repeat(" ", spacesLen)
	if char == 'A' {
		return spaces + "A" + spaces
	}
	innerLen := int(char-'A')*2 - 1
	innerSpaces := strings.Repeat(" ", innerLen)
	return spaces + string(char) + innerSpaces + string(char) + spaces
}

func Gen(char byte) (string, error) {
	if char < 'A' || char > 'Z' {
		return "", errors.New("invalid")
	}

	c := byte('A')
	spacesLen := int(char - c)
	arr := []string{}

	for c < char {
		r := row(c, spacesLen)
		arr = append(arr, r)
		c++
		spacesLen--
	}

	for c >= 'A' {
		r := row(c, spacesLen)
		arr = append(arr, r)
		c--
		spacesLen++
	}

	return strings.Join(arr, "\n"), nil
}
