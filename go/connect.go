package connect

var dirs = [][2]int{
	{0, -1},
	{0, 1},
	{-1, 0},
	{-1, 1},
	{1, -1},
	{1, 0},
}

func check(lines []string, q [][2]int, target byte, fn func(i, j int) bool) bool {
	visited := map[[2]int]bool{}

	for len(q) > 0 {
		pos := q[0]
		q = q[1:]

		if visited[pos] {
			continue
		}

		visited[pos] = true

		i, j := pos[0], pos[1]

		if fn(i, j) {
			return true
		}

		for _, d := range dirs {
			ni := i + d[0]
			nj := j + d[1]

			if ni >= 0 && ni < len(lines) && nj >= 0 && nj < len(lines[ni]) && lines[ni][nj] == target {
				q = append(q, [2]int{ni, nj})
			}
		}

	}

	return false
}

func checkPlayerO(lines []string) bool {
	q := [][2]int{}
	for i, c := range lines[0] {
		if c == 'O' {
			q = append(q, [2]int{0, i})
		}
	}

	return check(lines, q, 'O', func(i, j int) bool {
		return i == len(lines)-1
	})
}

func checkPlayerX(lines []string) bool {
	q := [][2]int{}
	for i := range lines {
		if lines[i][0] == 'X' {
			q = append(q, [2]int{i, 0})
		}
	}

	return check(lines, q, 'X', func(i, j int) bool {
		return j == len(lines[i])-1
	})
}

func ResultOf(lines []string) (string, error) {
	if checkPlayerO(lines) {
		return "O", nil
	}

	if checkPlayerX(lines) {
		return "X", nil
	}

	return "", nil
}
