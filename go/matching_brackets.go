package brackets

func Bracket(input string) bool {
	st := []rune{}
	for _, c := range input {
		switch c {
		case '(':
			st = append(st, ')')
		case '{':
			st = append(st, '}')
		case '[':
			st = append(st, ']')
		case ']':
			fallthrough
		case ')':
			fallthrough
		case '}':
			if len(st) == 0 || st[len(st)-1] != c {
				return false
			}
			st = st[:len(st)-1]
		}
	}
	return len(st) == 0
}
