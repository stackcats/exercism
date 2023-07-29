from typing import Any, Self


class Node:

    def __init__(self,
                 value: Any,
                 succeeding: Self | None = None,
                 previous: Self | None = None):
        self.value = value
        self.next = succeeding
        self.prev = previous


class LinkedList:

    def __init__(self):
        self.head = None
        self.tail = None
        self.ct = 0

    def __len__(self) -> int:
        return self.ct

    def push(self, value: Any):
        node = Node(value)
        if self.tail is None:
            self.head = node
        else:
            self.tail.next = node
            node.prev = self.tail

        self.ct += 1
        self.tail = node

    def pop(self) -> Any:
        if self.tail is None:
            raise IndexError('List is empty')

        node = self.tail
        self.tail = self.tail.prev
        if self.tail is None:
            self.head = None
        else:
            self.tail.next = None
        self.ct -= 1
        return node.value

    def unshift(self, value: Any):
        node = Node(value)
        if self.head is None:
            self.tail = node
        else:
            node.next = self.head
            self.head.prev = node

        self.head = node
        self.ct += 1

    def shift(self) -> Any:
        if self.head is None:
            raise IndexError('List is empty')

        node = self.head
        self.head = self.head.next
        if self.head is None:
            self.tail = None
        else:
            self.head.prev = None
        self.ct -= 1
        return node.value

    def delete(self, value):
        if self.head is None:
            raise ValueError('Value not found')
        curr = self.head
        while curr != None:
            if curr.value == value:
                break
            curr = curr.next

        if curr is None:
            raise ValueError('Value not found')

        if curr.prev is None:
            self.shift()
            return

        if curr.next is None:
            self.pop()
            return

        curr.next.prev = curr.prev
        curr.prev.next = curr.next
        self.ct -= 1
