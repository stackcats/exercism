package circular

import "errors"

// Implement a circular buffer of bytes supporting both overflow-checked writes
// and unconditional, possibly overwriting, writes.
//
// We chose the provided API so that Buffer implements io.ByteReader
// and io.ByteWriter and can be used (size permitting) as a drop in
// replacement for anything using that interface.

// Define the Buffer type here.
type Buffer struct {
	size  int
	buf   []byte
	front int
	rear  int
}

func NewBuffer(size int) *Buffer {
	return &Buffer{
		size:  0,
		buf:   make([]byte, size),
		front: 0,
		rear:  0,
	}
}

func (b *Buffer) bump(i int) int {
	return (i + 1) % len(b.buf)
}

func (b *Buffer) isEmpty() bool {
	return b.size == 0
}

func (b *Buffer) isFull() bool {
	return b.size == len(b.buf)
}

func (b *Buffer) ReadByte() (byte, error) {
	if b.isEmpty() {
		return 0, errors.New("empty")
	}
	v := b.buf[b.front]
	b.front = b.bump(b.front)
	b.size--
	return v, nil
}

func (b *Buffer) WriteByte(c byte) error {
	if b.isFull() {
		return errors.New("full")
	}
	b.buf[b.rear] = c
	b.rear = b.bump(b.rear)
	b.size++
	return nil
}

func (b *Buffer) Overwrite(c byte) {
	if b.isFull() {
		b.buf[b.front] = c
		b.front = b.bump(b.front)
	} else {
		b.WriteByte(c)
	}
}

func (b *Buffer) Reset() {
	b.buf = make([]byte, len(b.buf))
	b.front = 0
	b.rear = 0
	b.size = 0
}
