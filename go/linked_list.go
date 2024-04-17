package linkedlist

import "errors"

type Node struct {
	Value any
	prev  *Node
	next  *Node
}

type List struct {
	head *Node
	tail *Node
}

func NewList(elements ...interface{}) *List {
	l := &List{}
	for _, elem := range elements {
		l.Push(elem)
	}
	return l
}

func (n *Node) Next() *Node {
	return n.next
}

func (n *Node) Prev() *Node {
	return n.prev
}

func (l *List) Unshift(v interface{}) {
	node := &Node{}
	node.Value = v
	if l.head == nil {
		l.tail = node
	} else {
		l.head.prev = node
		node.next = l.head
	}

	l.head = node
}

func (l *List) Push(v interface{}) {
	node := &Node{}
	node.Value = v
	if l.head == nil {
		l.head = node
	} else {
		l.tail.next = node
		node.prev = l.tail
	}

	l.tail = node
}

func (l *List) Shift() (interface{}, error) {
	if l.head == nil {
		return nil, errors.New("empty")
	}

	node := l.head
	l.head = node.next
	if l.head == nil {
		l.tail = nil
	} else {
		l.head.prev = nil
	}
	return node.Value, nil
}

func (l *List) Pop() (interface{}, error) {
	if l.head == nil {
		return nil, errors.New("empty")
	}

	node := l.tail
	l.tail = node.prev
	if l.tail == nil {
		l.head = nil
	} else {
		l.tail.next = nil
	}
	return node.Value, nil
}

func (l *List) Reverse() {
	if l.head == nil {
		return
	}

	for curr := l.head; curr != nil; curr = curr.prev {
		curr.next, curr.prev = curr.prev, curr.next
	}

	l.head, l.tail = l.tail, l.head
}

func (l *List) First() *Node {
	return l.head
}

func (l *List) Last() *Node {
	return l.tail
}
