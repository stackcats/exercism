package ledger

import (
	"cmp"
	"errors"
	"fmt"
	"slices"
	"strconv"
	"strings"
	"time"
)

type Entry struct {
	Date        string // "Y-m-d"
	Description string
	Change      int // in cents
}

func FormatHeader(locale string) string {
	titles := []string{"Date", "Description", "Change"}
	if locale == "nl-NL" {
		titles = []string{"Datum", "Omschrijving", "Verandering"}
	}
	return fmt.Sprintf("%-10s | %-25s | %s\n", titles[0], titles[1], titles[2])
}

func FormatDate(date, locale string) string {
	t, err := time.Parse(time.DateOnly, date)
	if err != nil {
		return ""
	}

	layout := "01/02/2006"
	if locale == "nl-NL" {
		layout = "02-01-2006"
	}

	return t.Format(layout)
}

func abs(n int) int {
	if n < 0 {
		return -n
	}
	return n
}

func FormatChange(change int, currency, locale string) string {
	integer := abs(change) / 100
	integer_str := "0"
	if integer > 0 {
		arr := []string{}
		for integer > 0 {
			arr = append(arr, strconv.Itoa(integer%1000))
			integer /= 1000
		}
		slices.Reverse(arr)
		delimiter := ","
		if locale == "nl-NL" {
			delimiter = "."
		}
		integer_str = strings.Join(arr, delimiter)
	}

	decimal := abs(change) % 100

	sign := "$"
	if currency == "EUR" {
		sign = "€"
	}

	dot_delimiter := "."
	s := fmt.Sprintf("%s%s%s%02d", sign, integer_str, dot_delimiter, decimal)

	if locale == "nl-NL" {
		dot_delimiter = ","
		neg := " "
		if change < 0 {
			neg = "-"
		}
		s = fmt.Sprintf("%s %s%s%02d%s", sign, integer_str, dot_delimiter, decimal, neg)
	} else {
		if change < 0 {
			s = "(" + s + ")"
		} else {
			s += " "
		}
	}

	return s
}

func FormatLedger(currency string, locale string, entries []Entry) (string, error) {
	if locale != "en-US" && locale != "nl-NL" {
		return "", errors.New("invalid locale")
	}

	if currency != "USD" && currency != "EUR" {
		return "", errors.New("invalid currency")
	}

	entriesCopy := append([]Entry{}, entries...)

	slices.SortFunc(entriesCopy, func(a, b Entry) int {
		r := cmp.Compare(a.Date, b.Date)
		if r != 0 {
			return r
		}
		r = cmp.Compare(a.Change, b.Change)
		if r != 0 {
			return r
		}
		return cmp.Compare(a.Description, b.Description)
	})

	s := &strings.Builder{}
	s.WriteString(FormatHeader(locale))

	for _, entry := range entriesCopy {
		date := FormatDate(entry.Date, locale)
		if date == "" {
			return "", errors.New("invalid date")
		}

		desc := entry.Description
		if len(desc) > 25 {
			desc = desc[:22] + "..."
		}

		change := FormatChange(entry.Change, currency, locale)

		row := fmt.Sprintf("%s | %-25s | %13s\n", date, desc, change)

		s.WriteString(row)
	}

	return s.String(), nil
}
