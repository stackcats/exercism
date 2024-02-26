/* These implementation definitions enable zero-argument contructors:
 *    throw EmptyBufferException();
 */

class EmptyBufferException implements Exception {}

class FullBufferException implements Exception {}

class CircularBuffer {
  final List<int> arr;
  int len = 0;
  int front = 0;
  int rear = 0;

  CircularBuffer(int cap) : arr = List.generate(cap, (_) => 0);

  void write(int n, {bool force = false}) {
    if (len == arr.length) {
      if (force) {
        arr[front] = n;
        front = (front + 1) % arr.length;
        return;
      }
      throw FullBufferException();
    }
    arr[rear] = n;
    rear = (rear + 1) % arr.length;
    len++;
  }

  int read() {
    if (len == 0) {
      throw EmptyBufferException();
    }
    final r = arr[front];
    front = (front + 1) % arr.length;
    len--;
    return r;
  }

  void clear() {
    len = 0;
    front = 0;
    rear = 0;
  }
}
