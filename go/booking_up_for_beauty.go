package booking

import "time"

func Schedule(date string) time.Time {
	t, _ := time.Parse("1/2/2006 15:04:05", date)
	return t
}

func HasPassed(date string) bool {
	t, _ := time.Parse("January 2, 2006 15:04:05", date)
	return time.Now().After(t)
}

func IsAfternoonAppointment(date string) bool {
	t, _ := time.Parse("Monday, January 2, 2006 15:04:05", date)
	return t.Hour() >= 12 && t.Hour() < 18
}

func Description(date string) string {
	t := Schedule(date)
	return t.Format("You have an appointment on Monday, January 2, 2006, at 15:04.")
}

func AnniversaryDate() time.Time {
	now := time.Now()
	t := time.Date(now.Year(), 9, 15, 0, 0, 0, 0, time.UTC)
	return t
}
