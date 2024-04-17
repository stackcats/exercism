package cryptosquare

import (
	"math"
	"regexp"
	"strings"
)

func Encode(pt string) string {
	re := regexp.MustCompile(`[^\w\d]`)
	pt = re.ReplaceAllString(pt, "")
	pt = strings.ToLower(pt)

	sq := math.Sqrt(float64(len(pt)))
	r := int(math.Floor(sq))
	c := int(math.Ceil(sq))
	if r*c < len(pt) {
		r = c
	}
	if r*c < len(pt) {
		c += 1
	}

	s := []byte{}
	for i := 0; i < c; i++ {
		if len(s) > 0 {
			s = append(s, byte(' '))
		}
		for j := 0; j < r; j++ {
			ndx := j*c + i
			if ndx < len(pt) {
				s = append(s, pt[ndx])
			} else {
				s = append(s, byte(' '))
			}
		}
	}
	return string(s)
}
