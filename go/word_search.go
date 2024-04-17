package wordsearch

import (
	"errors"
)

func check(puzzle []string, word string, x, y int) [2][2]int {
	dirs := [][]int{
		{-1, -1},
		{-1, 0},
		{-1, 1},
		{0, 1},
		{1, 1},
		{1, 0},
		{1, -1},
		{0, -1},
	}

	for i, c := range word {
		narr := [][]int{}
		for _, each := range dirs {
			nx, ny := x+i*each[0], y+i*each[1]
			if nx >= 0 && nx < len(puzzle) && ny >= 0 && ny < len(puzzle[0]) && puzzle[nx][ny] == byte(c) {
				narr = append(narr, each)
			}
		}
		dirs = narr
		if len(dirs) == 0 {
			break
		}
	}

	if len(dirs) > 0 {
		return [2][2]int{{y, x}, {y + dirs[0][1]*(len(word)-1), x + dirs[0][0]*(len(word)-1)}}
	}
	return [2][2]int{{-1, -1}, {-1, -1}}
}

func Solve(words []string, puzzle []string) (map[string][2][2]int, error) {
	mp := map[string][2][2]int{}
	visited := map[string]bool{}

	for i, line := range puzzle {
		for j := range line {
			for _, word := range words {
				if visited[word] {
					continue
				}
				r := check(puzzle, word, i, j)
				mp[word] = r
				if r[0][0] != -1 {
					visited[word] = true
				}
			}
		}
	}

	for _, v := range mp {
		if v[0][0] == -1 {
			return mp, errors.New("notfound")
		}
	}

	return mp, nil
}
