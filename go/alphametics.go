package alphametics

import (
	"errors"
	"slices"
	"strings"
	"unicode"
)

func permutations(nums []int, k int) [][]int {
	result := [][]int{}
	visited := make([]bool, len(nums))
	current := []int{}
	backtrack(nums, visited, current, k, &result)
	return result
}

func backtrack(nums []int, visited []bool, current []int, k int, result *[][]int) {
	if len(current) == k {
		tmp := make([]int, k)
		copy(tmp, current)
		*result = append(*result, tmp)
		return
	}

	for i := 0; i < len(nums); i++ {
		if visited[i] {
			continue
		}
		visited[i] = true
		current = append(current, nums[i])
		backtrack(nums, visited, current, k, result)
		current = current[:len(current)-1]
		visited[i] = false
	}
}

func toNum(s string, mp map[string]int) (int, bool) {
	if len(s) > 1 && mp[string(s[0])] == 0 {
		return 0, false
	}
	n := 0
	for _, c := range s {
		n = n*10 + mp[string(c)]
	}
	return n, true
}

func check(vars []string, res string, mp map[string]int) bool {
	s := 0
	for _, v := range vars {
		n, ok := toNum(v, mp)
		if !ok {
			return false
		}
		s += n
	}

	r, ok := toNum(res, mp)
	if !ok {
		return false
	}

	return s == r
}

func Solve(puzzle string) (map[string]int, error) {
	mp := map[string]int{}
	for _, c := range puzzle {
		if unicode.IsLetter(c) {
			mp[string(c)] = 0
		}
	}

	keys := []string{}
	for k := range mp {
		keys = append(keys, k)
	}
	slices.Sort(keys)
	ps := permutations([]int{0, 1, 2, 3, 4, 5, 6, 7, 8, 9}, len(keys))

	arr := strings.Split(puzzle, " == ")
	rht := arr[len(arr)-1]
	vars := strings.Split(arr[0], " + ")

	for _, p := range ps {
		for i, k := range keys {
			mp[k] = p[i]
		}
		if check(vars, rht, mp) {
			return mp, nil
		}
	}

	return nil, errors.New("no solution")
}
