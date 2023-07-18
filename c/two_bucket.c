#include "two_bucket.h"

#include <math.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct list_node {
  bucket_liters_t b1;
  bucket_liters_t b2;
  int count;
  struct list_node *next;
} list_node_t;

typedef struct {
  list_node_t *head;
  list_node_t *tail;
} queue_t;

queue_t *create_queue();
bool queue_is_empty(queue_t *q);
void dequeue(queue_t *q, bucket_liters_t *b1, bucket_liters_t *b2, int *count);
void enqueue(queue_t *q, bucket_liters_t b1, bucket_liters_t b2, int count);
void free_queue(queue_t *q);
bool queue_contains(queue_t *q, bucket_liters_t b1, bucket_liters_t b2);
char *strdup(const char *s);

bucket_result_t measure(bucket_liters_t bucket_1_size,
                        bucket_liters_t bucket_2_size,
                        bucket_liters_t goal_volume, bucket_id_t start_bucket) {
  bucket_result_t res;
  queue_t *q = create_queue();
  queue_t *set = create_queue();
  bucket_liters_t b1 = 0, b2 = 0;
  int count = 0;
  enqueue(q, b1, b2, count);
  while (!queue_is_empty(q)) {
    dequeue(q, &b1, &b2, &count);
    if (queue_contains(set, b1, b2)) {
      continue;
    }
    enqueue(set, b1, b2, 0);
    if (start_bucket == BUCKET_ID_1) {
      if (b1 == 0 && b2 == bucket_2_size) {
        continue;
      }
    } else {
      if (b1 == bucket_1_size && b2 == 0) {
        continue;
      }
    }
    if (b1 == goal_volume) {
      res.possible = true;
      res.goal_bucket = BUCKET_ID_1;
      res.move_count = count;
      res.other_bucket_liters = b2;
      goto RET;
    }
    if (b2 == goal_volume) {
      res.possible = true;
      res.goal_bucket = BUCKET_ID_2;
      res.move_count = count;
      res.other_bucket_liters = b1;
      goto RET;
    }
    bucket_liters_t diff = fmin(bucket_2_size - b2, b1);
    enqueue(q, b1 - diff, b2 + diff, count + 1);
    enqueue(q, 0, b2, count + 1);
    enqueue(q, bucket_1_size, b2, count + 1);
    diff = fmin(bucket_1_size - b1, b2);
    enqueue(q, b1 + diff, b2 - diff, count + 1);
    enqueue(q, b1, 0, count + 1);
    enqueue(q, b1, bucket_2_size, count + 1);
  }

  res.possible = false;

RET:
  free_queue(q);
  free_queue(set);
  return res;
}

queue_t *create_queue() {
  queue_t *q = malloc(sizeof(queue_t));
  if (q == NULL) {
    return NULL;
  }

  q->head = NULL;
  q->tail = NULL;
  return q;
}

bool queue_is_empty(queue_t *q) { return q->head == NULL; }

void dequeue(queue_t *q, bucket_liters_t *b1, bucket_liters_t *b2, int *count) {
  list_node_t *node = q->head;
  q->head = node->next;
  if (q->head == NULL) {
    q->tail = NULL;
  }

  *b1 = node->b1;
  *b2 = node->b2;
  *count = node->count;
  free(node);
}

void enqueue(queue_t *q, bucket_liters_t b1, bucket_liters_t b2, int count) {
  list_node_t *node = malloc(sizeof(list_node_t));
  if (node == NULL) {
    return;
  }
  node->b1 = b1;
  node->b2 = b2;
  node->count = count;
  node->next = NULL;

  if (q->tail == NULL) {
    q->head = node;
    q->tail = node;
  } else {
    q->tail->next = node;
    q->tail = node;
  }
}

void free_queue(queue_t *q) {
  while (q->head != NULL) {
    list_node_t *node = q->head;
    q->head = q->head->next;
    free(node);
  }
  free(q);
  q = NULL;
}

bool queue_contains(queue_t *q, bucket_liters_t b1, bucket_liters_t b2) {
  list_node_t *curr = q->head;
  while (curr != NULL) {
    if (curr->b1 == b1 && curr->b2 == b2) {
      return true;
    }
    curr = curr->next;
  }
  return false;
}
