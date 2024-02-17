package birdwatcher

func TotalBirdCount(birdsPerDay []int) int {
	ct := 0
	for _, birds := range birdsPerDay {
		ct += birds
	}
	return ct
}

func BirdsInWeek(birdsPerDay []int, week int) int {
	ct := 0
	start := (week - 1) * 7
	for i := start; i < start+7; i++ {
		ct += birdsPerDay[i]
	}
	return ct
}

func FixBirdCountLog(birdsPerDay []int) []int {
	for i := 0; i < len(birdsPerDay); i++ {
		if i%2 == 0 {
			birdsPerDay[i] += 1
		}
	}
	return birdsPerDay
}
