package dominoes

// Define the Domino type here.
type Domino [2]int

func dfs(input []Domino, chain []Domino) []Domino {
	if len(input) == 0 {
		if chain[0][0] == chain[len(chain)-1][1] {
			return chain
		} else {
			return nil
		}
	}

	for i, d := range input {
		removed := append([]Domino{}, input[:i]...)
		removed = append(removed, input[i+1:]...)
		if len(chain) == 0 || d[0] == chain[len(chain)-1][1] {
			nChain := append([]Domino{}, chain...)
			nChain = append(nChain, d)
			tried := dfs(removed, nChain)
			if tried != nil {
				return tried
			}
		}
		d = Domino{d[1], d[0]}
		if len(chain) == 0 || d[0] == chain[len(chain)-1][1] {
			nChain := append([]Domino{}, chain...)
			nChain = append(nChain, d)
			tried := dfs(removed, nChain)
			if tried != nil {
				return tried
			}
		}
	}
	return nil
}

func MakeChain(input []Domino) ([]Domino, bool) {
	if len(input) == 0 {
		return []Domino{}, true
	}

	chain := dfs(input, []Domino{})

	return chain, chain != nil
}
