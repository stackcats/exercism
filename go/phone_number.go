package phonenumber

import (
	"errors"
	"fmt"
	"unicode"
)

func Number(phoneNumber string) (string, error) {
	s := []rune{}
	for _, c := range phoneNumber {
		if unicode.IsDigit(c) {
			s = append(s, c)
		}
	}

	if s[0] == '1' {
		s = s[1:]
	}

	if len(s) != 10 {
		return "", errors.New("invalid")
	}

	if s[0] < '2' || s[3] < '2' {
		return "", errors.New("invalid")
	}

	return string(s), nil
}

func AreaCode(phoneNumber string) (string, error) {
	phoneNumber, err := Number(phoneNumber)
	if err != nil {
		return "", err
	}

	return string(phoneNumber[:3]), nil
}

func Format(phoneNumber string) (string, error) {
	phoneNumber, err := Number(phoneNumber)
	if err != nil {
		return "", err
	}
	return fmt.Sprintf("(%s) %s-%s", string(phoneNumber[:3]), string(phoneNumber[3:6]), string(phoneNumber[6:])), nil
}
