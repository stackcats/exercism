package twobucket

import (
	"errors"
)

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func Solve(sizeBucketOne, sizeBucketTwo, goalAmount int, startBucket string) (string, int, int, error) {
	if sizeBucketOne <= 0 || sizeBucketTwo <= 0 || goalAmount <= 0 {
		return "", 0, 0, errors.New("invalid")
	}

	if startBucket != "one" && startBucket != "two" {
		return "", 0, 0, errors.New("invalid")
	}

	visited := map[[2]int]bool{}

	q := [][3]int{{0, 0, 0}}

	for len(q) > 0 {
		b1, b2, ct := q[0][0], q[0][1], q[0][2]
		q = q[1:]

		if startBucket == "one" {
			if b1 == 0 && b2 == sizeBucketTwo {
				continue
			}
		} else {
			if b1 == sizeBucketOne && b2 == 0 {
				continue
			}
		}

		if visited[[2]int{b1, b2}] {
			continue
		}
		visited[[2]int{b1, b2}] = true

		if b1 == goalAmount {
			return "one", ct, b2, nil
		}

		if b2 == goalAmount {
			return "two", ct, b1, nil
		}

		diff := min(b1, sizeBucketTwo-b2)
		q = append(q, [3]int{b1 - diff, b2 + diff, ct + 1})

		q = append(q, [3]int{sizeBucketOne, b2, ct + 1})

		q = append(q, [3]int{0, b2, ct + 1})

		diff = min(sizeBucketOne-b1, b2)
		q = append(q, [3]int{b1 + diff, b2 - diff, ct + 1})

		q = append(q, [3]int{b1, sizeBucketTwo, ct + 1})

		q = append(q, [3]int{b1, 0, ct + 1})
	}

	return "", 0, 0, errors.New("impossible")
}
