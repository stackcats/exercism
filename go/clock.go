package clock

import (
	"fmt"
)

// Clock ...
type Clock struct {
	hour   int
	minute int
}

// New ...
func New(hour, minute int) Clock {
	for minute < 0 {
		minute += 60
		hour--
	}

	for hour < 0 {
		hour += 24
	}

	hour += minute / 60

	return Clock{
		hour:   hour % 24,
		minute: minute % 60,
	}
}

// String ...
func (c Clock) String() string {
	return fmt.Sprintf("%02d:%02d", c.hour, c.minute)
}

// Add ...
func (c Clock) Add(minutes int) Clock {
	return New(c.hour, c.minute+minutes)
}

// Subtract ...
func (c Clock) Subtract(minutes int) Clock {
	return New(c.hour, c.minute-minutes)
}
