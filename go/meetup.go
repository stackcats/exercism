package meetup

import "time"

type WeekSchedule int

const (
    First = iota
    Second
    Third
    Fourth
    Fifth
    Last
    Teenth
)


func Day(wSched WeekSchedule, wDay time.Weekday, month time.Month, year int) int {
    start := time.Date(year, month, 1, 0, 0, 0, 0, time.UTC)
    end := start.AddDate(0, 1, 0)

    arr := []time.Time{}
    
    for start.Before(end) {
        if start.Weekday() == wDay {
            arr = append(arr, start)
        }
        start = start.AddDate(0, 0, 1)
    }

    if wSched == Last {
        return arr[len(arr) - 1].Day()
    }

    if wSched == Teenth {
        for _, t := range arr {
            if t.Day() >= 13 {
                return t.Day()
            }
        }
    }

    return arr[wSched].Day()
}

