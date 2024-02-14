package diffsquares

func SquareOfSum(n int) int {
	sum := (1 + n) * n / 2
	return sum * sum
}

func SumOfSquares(n int) (sum int) {
	sum = n * (n + 1) * (2*n + 1) / 6
	return
}

func Difference(n int) int {
	return SquareOfSum(n) - SumOfSquares(n)
}
