package poker

import (
	"cmp"
	"errors"
	"slices"
	"strings"
)

var (
	ErrInvalid = errors.New("invalid")
	values     = []string{"2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"}
	suits      = []rune{'♡', '♢', '♧', '♤'}
)

type Hand struct {
	cards []int
	rank  int
}

func (h *Hand) Compare(other *Hand) int {
	if h.rank == other.rank {
		return slices.Compare(h.cards, other.cards)
	}
	return cmp.Compare(h.rank, other.rank)
}

func parseRank(cards []int, suitsNum int) int {
	counter := map[int]int{}
	for _, c := range cards {
		counter[c]++
	}

	slices.SortFunc(cards, func(a, b int) int {
		if counter[a] > counter[b] {
			return -1
		} else if counter[a] < counter[b] {
			return 1
		}
		return cmp.Compare(b, a)
	})

	if slices.Equal(cards, []int{14, 13, 12, 11, 10}) || slices.Equal(cards, []int{14, 5, 4, 3, 2}) || (cards[0] == cards[1]+1 && cards[1] == cards[2]+1 && cards[2] == cards[3]+1 && cards[3] == cards[4]+1) {
		if slices.Equal(cards, []int{14, 5, 4, 3, 2}) {
			cards[0], cards[4] = cards[4], cards[0]
		}

		if suitsNum == 1 {
			return 9
		}

		return 5
	}

	if cards[0] == cards[3] {
		return 8
	}

	if cards[0] == cards[2] && cards[3] == cards[4] {
		return 7
	}

	if suitsNum == 1 {
		return 6
	}

	if cards[0] == cards[2] {
		return 4
	}

	if cards[0] == cards[1] && cards[2] == cards[3] {
		return 3
	}

	if cards[0] == cards[1] {
		return 2
	}

	return 1
}

func NewHand(s string) (*Hand, error) {
	arr := strings.Fields(s)
	if len(arr) != 5 {
		return nil, ErrInvalid
	}

	cards := []int{}
	suitsMp := map[rune]bool{}
	for _, each := range arr {
		c := []rune(each)
		if len(c) == 3 {
			if c[0] != '1' && c[1] != '0' {
				return nil, ErrInvalid
			}
		} else if len(c) != 2 {
			return nil, ErrInvalid
		}

		v := c[:len(c)-1]
		ndx := slices.Index(values, string(v))
		if ndx == -1 {
			return nil, ErrInvalid
		}

		cards = append(cards, ndx+2)

		suit := c[len(c)-1]
		if !slices.Contains(suits, suit) {
			return nil, ErrInvalid
		}
		suitsMp[suit] = true
	}

	rank := parseRank(cards, len(suitsMp))

	h := &Hand{cards: cards, rank: rank}

	return h, nil
}

func BestHand(hands []string) ([]string, error) {
	best, err := NewHand(hands[0])
	if err != nil {
		return []string{}, err
	}

	res := []string{hands[0]}

	for _, each := range hands[1:] {
		h, err := NewHand(each)
		if err != nil {
			return []string{}, err
		}

		r := best.Compare(h)
		if r < 0 {
			best = h
			res = []string{each}
		} else if r == 0 {
			res = append(res, each)
		}
	}

	return res, nil
}
