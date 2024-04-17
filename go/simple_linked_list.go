package linkedlist

import "errors"

// Define the List and Element types here.
type Element struct {
    value int
    next *Element
}

type List struct {
    head *Element
    len int
}

func New(elements []int) *List {
    l := &List{}
	for _, elem := range elements {
        l.Push(elem)
    }
	return l
}

func (l *List) Size() int {
	return l.len
}

func (l *List) Push(element int) {
	node := &Element{ value: element }
    node.next = l.head
    l.head = node
    l.len++
}

func (l *List) Pop() (int, error) {
	if l.len == 0 {
        return 0, errors.New("empty")
    }

    node := l.head
    l.head = l.head.next
    l.len--
    return node.value, nil
}

func (l *List) Array() []int {
	arr := make([]int, l.len)
    for curr, i := l.head, l.len - 1; curr != nil; curr, i = curr.next, i - 1 {
        arr[i] = curr.value
    }
	return arr
}

func (l *List) Reverse() *List {
	t := &List{}
    for curr := l.head; curr != nil; curr = curr.next {
        t.Push(curr.value)
    }
	return t
}

