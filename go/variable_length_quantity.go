package variablelengthquantity

import (
	"errors"
	"slices"
)

func EncodeVarint(input []uint32) []byte {
	res := []byte{}
	for i := len(input) - 1; i >= 0; i-- {
		v := input[i]
		if v == 0 {
			res = append(res, 0)
			continue
		}

		h := uint32(0)
		for v > 0 {
			d := v&0x7F | h
			res = append(res, byte(d))
			h |= 0x80
			v >>= 7
		}
	}
	slices.Reverse(res)
	return res
}

func DecodeVarint(input []byte) ([]uint32, error) {
	res := []uint32{}
	n := uint32(0)
	for _, v := range input {
		n += uint32(v) & 0x7f
		if v&0x80 == 0 {
			res = append(res, n)
			n = 0
		} else {
			n <<= 7
		}
	}
	if len(res) == 0 {
		return nil, errors.New("invalid")
	}
	return res, nil
}
