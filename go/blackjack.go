package blackjack

func ParseCard(card string) int {
	switch card {
	case "ace":
		return 11
	case "two":
		return 2
	case "three":
		return 3
	case "four":
		return 4
	case "five":
		return 5
	case "six":
		return 6
	case "seven":
		return 7
	case "eight":
		return 8
	case "nine":
		return 9
	case "ten", "jack", "queen", "king":
		return 10
	default:
		return 0
	}
}

func FirstTurn(card1, card2, dealerCard string) string {
	c1 := ParseCard(card1)
	c2 := ParseCard(card2)
	c := c1 + c2
	dc := ParseCard(dealerCard)
	switch {
	case c1 == 11 && c2 == 11:
		return "P"
	case c == 21:
		if dc != 11 && dc != 10 {
			return "W"
		}
		return "S"
	case c >= 17 && c <= 20:
		return "S"
	case c >= 12 && c <= 16 && dc < 7:
		return "S"
	default:
		return "H"
	}
}
