package purchase

import "fmt"

func NeedsLicense(kind string) bool {
	return kind == "car" || kind == "truck"
}

func ChooseVehicle(option1, option2 string) string {
	opt := option1
	if option1 > option2 {
		opt = option2
	}
	return fmt.Sprintf("%s is clearly the better choice.", opt)
}

func CalculateResellPrice(originalPrice, age float64) float64 {
	p := 1.0
	if age < 3 {
		p = 0.8
	} else if age < 10 {
		p = 0.7
	} else {
		p = 0.5
	}
	return originalPrice * p
}
