#include "circular_buffer.h"

#include <errno.h>
#include <stddef.h>
#include <stdlib.h>

int next(int i, size_t len);

circular_buffer_t *new_circular_buffer(size_t capacity) {
  circular_buffer_t *buffer =
      (circular_buffer_t *)malloc(sizeof(circular_buffer_t));
  if (buffer == NULL) {
    return NULL;
  }

  buffer->arr = (buffer_value_t *)malloc(sizeof(buffer_value_t) * capacity);
  if (buffer->arr == NULL) {
    return NULL;
  }

  buffer->capacity = capacity;
  buffer->front = 0;
  buffer->rear = 0;
  buffer->len = 0;

  return buffer;
}

int16_t read(circular_buffer_t *buffer, buffer_value_t *value) {
  if (buffer->len == 0) {
    errno = ENODATA;
    return EXIT_FAILURE;
  }

  *value = buffer->arr[buffer->front];
  buffer->front = next(buffer->front, buffer->capacity);

  buffer->len--;

  return EXIT_SUCCESS;
}

int16_t write(circular_buffer_t *buffer, buffer_value_t value) {
  if (buffer->len == buffer->capacity) {
    errno = ENOBUFS;
    return EXIT_FAILURE;
  }

  buffer->arr[buffer->rear] = value;
  buffer->rear = next(buffer->rear, buffer->capacity);

  buffer->len++;

  return EXIT_SUCCESS;
}

int16_t overwrite(circular_buffer_t *buffer, buffer_value_t value) {
  if (buffer->len == buffer->capacity) {
    buffer->arr[buffer->front] = value;
    buffer->front = next(buffer->front, buffer->capacity);
  } else {
    write(buffer, value);
  }
  return EXIT_SUCCESS;
}

void clear_buffer(circular_buffer_t *buffer) {
  buffer->front = 0;
  buffer->rear = 0;
  buffer->len = 0;
}

void delete_buffer(circular_buffer_t *buffer) {
  if (buffer == NULL) {
    return;
  }
  free(buffer->arr);
  free(buffer);
  buffer = NULL;
}

inline int next(int i, size_t len) { return (i + 1) % len; }
