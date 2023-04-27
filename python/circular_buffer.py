class BufferFullException(BufferError):
    """Exception raised when CircularBuffer is full.

    message: explanation of the error.

    """

    def __init__(self, message):
        self.message = message


class BufferEmptyException(BufferError):
    """Exception raised when CircularBuffer is empty.

    message: explanation of the error.

    """

    def __init__(self, message):
        self.message = message


class CircularBuffer:

    def __init__(self, capacity):
        self._buf = [None] * capacity
        self._front = 0
        self._rear = 0
        self._len = 0
        self._capacity = capacity

    def read(self):
        if self.is_empty():
            raise BufferEmptyException('Circular buffer is empty')
        val = self._buf[self._front]
        self._front = self.next(self._front)
        self._len -= 1
        return val

    def write(self, data):
        if self.is_full():
            raise BufferFullException('Circular buffer is full')
        self._buf[self._rear] = data
        self._rear = self.next(self._rear)
        self._len += 1

    def overwrite(self, data):
        if self.is_full():
            self._buf[self._front] = data
            self._front = self.next(self._front)
        else:
            self.write(data)

    def clear(self):
        self._buf = [None] * self._capacity
        self._front = 0
        self._rear = 0
        self._len = 0

    def next(self, curr):
        return (curr + 1) % self._capacity

    def is_empty(self):
        return self._len == 0

    def is_full(self):
        return self._len == self._capacity
