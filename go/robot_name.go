package robotname

import (
	"errors"
	"math/rand"
)

// Define the Robot type here.
type Robot struct {
	name string
}

var names = map[string]bool{}

func genName() string {
	name := make([]rune, 5)
	name[0] = rune(rand.Intn(26)) + 'A'
	name[1] = rune(rand.Intn(26)) + 'A'
	name[2] = rune(rand.Intn(10)) + '0'
	name[3] = rune(rand.Intn(10)) + '0'
	name[4] = rune(rand.Intn(10)) + '0'
	return string(name)
}

const totalNames = 26 * 26 * 10 * 10 * 10

func (r *Robot) Name() (string, error) {
	if r.name != "" {
		return r.name, nil
	}

	if len(names) == totalNames {
		return "", errors.New("full")
	}

	r.name = genName()
	for names[r.name] {
		r.name = genName()
	}
	names[r.name] = true
	return r.name, nil
}

func (r *Robot) Reset() {
	delete(names, r.name)
	r.name = ""
}
