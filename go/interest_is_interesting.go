package interest

func InterestRate(balance float64) float32 {
	if balance < 0 {
		return 3.213
	}
	if balance < 1000 {
		return 0.5
	}
	if balance < 5000 {
		return 1.621
	}
	return 2.475
}

func Interest(balance float64) float64 {
	return balance * float64(InterestRate(balance)) / 100
}

func AnnualBalanceUpdate(balance float64) float64 {
	return balance + Interest(balance)
}

func YearsBeforeDesiredBalance(balance, targetBalance float64) int {
	ct := 0
	for balance < targetBalance {
		balance = AnnualBalanceUpdate(balance)
		ct += 1
	}
	return ct
}
