from typing import Self, Any
from collections.abc import Iterator, Iterable


class Node:

    def __init__(self, value: Any):
        self._value = value
        self._next: Self | None = None

    def value(self) -> Any:
        return self._value

    def next(self) -> Self | None:
        return self._next

    def update_next(self, other: Self | None):
        self._next = other


class LinkedList(Iterable[Any]):

    def __init__(self, values: list[Any] = []):
        self._count = 0
        self._head: Node | None = None
        for v in values:
            self.push(v)

    def __len__(self) -> int:
        return self._count

    def head(self) -> Node:
        if self._head is None:
            raise EmptyListException('The list is empty.')
        return self._head

    def push(self, value: Any):
        node = Node(value)
        if self._head == None:
            self._head = node
        else:
            node.update_next(self._head)
            self._head = node

        self._count += 1

    def pop(self) -> Any:
        while self._head is not None:
            node = self._head
            self._head = node.next()
            self._count -= 1
            return node.value()

        raise EmptyListException('The list is empty.')

    def reversed(self) -> 'LinkedList':
        return LinkedList(list(self))

    def __iter__(self) -> Iterator[Any]:
        curr = self._head
        while curr is not None:
            yield curr.value()
            curr = curr.next()


class EmptyListException(Exception):

    def __init__(self, message: str):
        self.message = message
