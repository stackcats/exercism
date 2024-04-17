package forth

import (
	"errors"
	"strconv"
	"strings"
)

type Stack struct {
	arr []int
}

func (st *Stack) push(n int) {
	st.arr = append(st.arr, n)
}

func (st *Stack) pop() int {
	n := st.arr[len(st.arr)-1]
	st.arr = st.arr[:len(st.arr)-1]
	return n
}

func (st *Stack) peek() int {
	return st.arr[len(st.arr)-1]
}

func resetWords() map[string]interface{} {
	return map[string]interface{}{
		"+": func(st *Stack) {
			a := st.pop()
			b := st.pop()
			st.push(a + b)
		},
		"-": func(st *Stack) {
			a := st.pop()
			b := st.pop()
			st.push(b - a)
		},
		"*": func(st *Stack) {
			a := st.pop()
			b := st.pop()
			st.push(b * a)
		},
		"/": func(st *Stack) {
			a := st.pop()
			b := st.pop()
			st.push(b / a)
		},
		"dup": func(st *Stack) {
			a := st.peek()
			st.push(a)
		},
		"drop": func(st *Stack) {
			_ = st.pop()
		},
		"swap": func(st *Stack) {
			a := st.pop()
			b := st.pop()
			st.push(a)
			st.push(b)
		},
		"over": func(st *Stack) {
			a := st.pop()
			b := st.pop()
			st.push(b)
			st.push(a)
			st.push(b)
		},
	}
}

var words = resetWords()

func addWord(input string) {
	arr := strings.Split(input[2:len(input)-2], " ")
	word := arr[0]
	if _, err := strconv.Atoi(word); err == nil {
		panic("invalid")
	}

	cmd := strings.Join(arr[1:], " ")
	// use user's defined word
	if i, ok := words[cmd]; ok {
		if v, ok := i.(string); ok {
			cmd = v
		}
	}

	// redefine user's defined word
	if i, ok := words[word]; ok {
		if v, ok := i.(string); ok {
			cmd = strings.ReplaceAll(cmd, word, v)
		}
		words[arr[0]] = cmd
		return
	}

	words[arr[0]] = cmd
}

func runCmd(input string, st *Stack) {
	cmds := strings.Split(input, " ")
	for _, cmd := range cmds {
		if i, ok := words[cmd]; ok {
			switch v := i.(type) {
			case string:
				runCmd(v, st)
			default:
				fn := i.(func(*Stack))
				fn(st)
			}
			continue
		}
		n, err := strconv.Atoi(cmd)
		if err != nil {
			panic("invalid")
		}
		st.push(n)
	}
}

func Forth(input []string) (arr []int, err error) {
	words = resetWords()

	defer func() {
		if r := recover(); r != nil {
			arr = []int{}
			err = errors.New("invalid")
		}
	}()

	var st = &Stack{}

	for _, ipt := range input {
		ipt = strings.ToLower(ipt)

		if ipt[0] == ':' {
			addWord(ipt)
			continue
		}

		runCmd(ipt, st)
	}

	return st.arr, nil
}

