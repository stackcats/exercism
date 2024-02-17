package lasagna

func PreparationTime(layers []string, minute int) int {
	if minute == 0 {
		minute = 2
	}
	return len(layers) * minute
}

func Quantities(layers []string) (noodles int, sauce float64) {
	for _, v := range layers {
		if v == "noodles" {
			noodles += 50
		} else if v == "sauce" {
			sauce += 0.2
		}
	}
	return
}

func AddSecretIngredient(friends []string, mine []string) {
	mine[len(mine)-1] = friends[len(friends)-1]
}

func ScaleRecipe(quantities []float64, n int) []float64 {
	arr := make([]float64, len(quantities))
	for i, v := range quantities {
		arr[i] = v * float64(n) / 2
	}
	return arr
}
