package knapsack

type Item struct {
	Weight, Value int
}

// Knapsack takes in a maximum carrying capacity and a collection of items
// and returns the maximum value that can be carried by the knapsack
// given that the knapsack can only carry a maximum weight given by maximumWeight
func Knapsack(maximumWeight int, items []Item) int {
	dp := make([]int, maximumWeight+1)
	for _, item := range items {
		for i := maximumWeight; i >= item.Weight; i-- {
			dp[i] = max(dp[i-item.Weight]+item.Value, dp[i])
		}
	}
	return dp[maximumWeight]
}

func max(a, b int) int {
	if a < b {
		return b
	}
	return a
}
