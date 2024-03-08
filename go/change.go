package change

import (
	"errors"
	"slices"
)

func Change(coins []int, target int) ([]int, error) {
	if target < 0 {
		return nil, errors.New("negative target")
	}

	if target == 0 {
		return []int{}, nil
	}

	dp := make([]int, target+1)
	changedCoins := make([][]int, target+1)

	for i := 1; i < len(dp); i++ {
		dp[i] = target * 2
	}

	for amount := 1; amount <= target; amount++ {
		for _, c := range coins {
			if amount < c {
				continue
			}

			if dp[amount-c]+1 < dp[amount] {
				dp[amount] = dp[amount-c] + 1
				changedCoins[amount] = append([]int{c}, changedCoins[amount-c]...)
			}
		}
	}

	if len(changedCoins[target]) == 0 {
		return nil, errors.New("empty changed coins")
	}

	slices.Sort(changedCoins[target])

	return changedCoins[target], nil
}
