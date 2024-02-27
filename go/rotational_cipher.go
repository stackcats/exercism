package rotationalcipher

import "unicode"

func RotationalCipher(plain string, shiftKey int) string {
	arr := make([]rune, len(plain))
	for i, c := range plain {
		if unicode.IsUpper(c) {
			arr[i] = 'A' + (c+rune(shiftKey)-'A')%26
		} else if unicode.IsLower(c) {
			arr[i] = 'a' + (c+rune(shiftKey)-'a')%26
		} else {
			arr[i] = c
		}
	}
	return string(arr)
}
