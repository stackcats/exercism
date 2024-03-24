package paasio

import (
	"io"
	"sync"
)

type Counter struct {
	mu   sync.Mutex
	n    int64
	nops int
}

func (c *Counter) add(n int) {
	c.mu.Lock()
	defer c.mu.Unlock()

	c.n += int64(n)
	c.nops++
}

// Define readCounter and writeCounter types here.
type readCounter struct {
	reader io.Reader
	Counter
}

type writeCounter struct {
	writer io.Writer
	Counter
}

type rwCounter struct {
	ReadCounter
	WriteCounter
}

// For the return of the function NewReadWriteCounter, you must also define a type that satisfies the ReadWriteCounter interface.

func NewWriteCounter(writer io.Writer) WriteCounter {
	return &writeCounter{writer: writer}
}

func NewReadCounter(reader io.Reader) ReadCounter {
	return &readCounter{reader: reader}
}

func NewReadWriteCounter(readwriter io.ReadWriter) ReadWriteCounter {
	return &rwCounter{
		NewReadCounter(readwriter),
		NewWriteCounter(readwriter),
	}
}

func (rc *readCounter) Read(p []byte) (int, error) {
	n, err := rc.reader.Read(p)
	if err != nil {
		return 0, err
	}
	rc.add(n)
	return n, err
}

func (rc *readCounter) ReadCount() (int64, int) {
	rc.mu.Lock()
	defer rc.mu.Unlock()
	return rc.n, rc.nops
}

func (wc *writeCounter) Write(p []byte) (int, error) {
	n, err := wc.writer.Write(p)
	if err != nil {
		return 0, err
	}
	wc.add(n)
	return n, err
}

func (wc *writeCounter) WriteCount() (int64, int) {
	wc.mu.Lock()
	defer wc.mu.Unlock()
	return wc.n, wc.nops
}
