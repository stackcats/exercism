package perfect

import "errors"

// Define the Classification type here.
type Classification int

const (
	ClassificationPerfect = iota
	ClassificationAbundant
	ClassificationDeficient
)

var ErrOnlyPositive = errors.New("GivesPositiveRequiredError")

func Classify(n int64) (Classification, error) {
	if n <= 0 {
		return 0, ErrOnlyPositive
	}

	if n == 1 {
		return ClassificationDeficient, nil
	}

	sum := int64(1)
	for i := int64(2); i < n; i++ {
		if n%i == 0 {
			sum += i
		}
	}
	if sum == n {
		return ClassificationPerfect, nil
	}
	if sum > n {
		return ClassificationAbundant, nil
	}
	return ClassificationDeficient, nil
}
