package allergies

var items = map[string]uint{
	"eggs":         1,
	"peanuts":      2,
	"shellfish":    4,
	"strawberries": 8,
	"tomatoes":     16,
	"chocolate":    32,
	"pollen":       64,
	"cats":         128,
}

func Allergies(allergies uint) []string {
	arr := []string{}
	for k := range items {
		if AllergicTo(allergies, k) {
			arr = append(arr, k)
		}
	}
	return arr
}

func AllergicTo(allergies uint, allergen string) bool {
	return allergies&items[allergen] > 0
}
