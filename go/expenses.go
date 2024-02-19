package expenses

import "fmt"

type Record struct {
	Day      int
	Amount   float64
	Category string
}

type DaysPeriod struct {
	From int
	To   int
}

func Filter(in []Record, predicate func(Record) bool) []Record {
	out := []Record{}
	for _, r := range in {
		if predicate(r) {
			out = append(out, r)
		}
	}
	return out
}

func ByDaysPeriod(p DaysPeriod) func(Record) bool {
	return func(r Record) bool {
		return r.Day >= p.From && r.Day <= p.To
	}
}

func ByCategory(c string) func(Record) bool {
	return func(r Record) bool {
		return r.Category == c
	}
}

func TotalByPeriod(in []Record, p DaysPeriod) float64 {
	total := 0.0
	for _, r := range Filter(in, ByDaysPeriod(p)) {
		total += r.Amount
	}
	return total
}

func CategoryExpenses(in []Record, p DaysPeriod, c string) (float64, error) {
	filtered := Filter(in, ByCategory(c))
	if len(filtered) == 0 {
		return 0, fmt.Errorf("unknown category %s", c)
	}

	return TotalByPeriod(filtered, p), nil
}
