#include "react.h"

#include <stdlib.h>

typedef struct callback_data {
  void *info;
  callback func;
  callback_id id;
  int value;
  struct callback_data *next;
} callback_data_t;

typedef enum { INPUT, COMPUTE1, COMPUTE2 } cell_type;

typedef struct cell {
  int value;
  cell_type type;
  struct cell *next;
  struct cell *input1;
  struct cell *input2;
  struct cell *output_chain;
  struct reactor *outputs;
  union {
    compute1 func1;
    compute2 func2;
  } compute;
  callback_data_t *callbacks;
  size_t num_of_callbacks;
} cell_t;

typedef struct reactor {
  cell_t *head;
  cell_t *tail;
} reactor_t;

void reactor_add_cell(reactor_t *r, cell_t *c);
void reactor_add_output(reactor_t *r, cell_t *c);
void cell_update_value(cell_t *c);
int cell_compute_value(cell_t *c);
void cell_callback(cell_t *c);

reactor_t *create_reactor(void) {
  reactor_t *r = malloc(sizeof(reactor_t));
  if (r == NULL) {
    return NULL;
  }
  r->head = NULL;
  r->tail = NULL;
  return r;
}

void destroy_reactor(reactor_t *r) {
  while (r->head != NULL) {
    cell_t *c = r->head;
    r->head = c->next;
    free(c);
  }
  free(r);
}

cell_t *create_input_cell(reactor_t *r, int initial_value) {
  cell_t *c = malloc(sizeof(cell_t));
  if (c == NULL) {
    return NULL;
  }
  c->value = initial_value;
  c->type = INPUT;
  c->next = NULL;
  c->input1 = NULL;
  c->input2 = NULL;
  c->output_chain = NULL;
  c->outputs = create_reactor();
  c->callbacks = NULL;
  c->num_of_callbacks = 0;
  reactor_add_cell(r, c);
  return c;
}

cell_t *create_compute1_cell(reactor_t *r, cell_t *input, compute1 compute) {
  cell_t *c = malloc(sizeof(cell_t));
  if (c == NULL) {
    return NULL;
  }
  c->value = compute(input->value);
  c->type = COMPUTE1;
  c->next = NULL;
  c->input1 = input;
  c->input2 = NULL;
  c->outputs = create_reactor();
  c->compute.func1 = compute;
  c->callbacks = NULL;
  c->num_of_callbacks = 0;
  c->output_chain = NULL;
  reactor_add_output(input->outputs, c);
  reactor_add_cell(r, c);
  return c;
}

cell_t *create_compute2_cell(reactor_t *r, cell_t *input1, cell_t *input2,
                             compute2 compute) {

  cell_t *c = malloc(sizeof(cell_t));
  if (c == NULL) {
    return NULL;
  }
  c->value = compute(input1->value, input2->value);
  c->type = COMPUTE2;
  c->next = NULL;
  c->input1 = input1;
  c->input2 = input2;
  c->outputs = create_reactor();
  c->compute.func2 = compute;
  c->callbacks = NULL;
  c->num_of_callbacks = 0;
  c->output_chain = NULL;
  reactor_add_output(input1->outputs, c);
  reactor_add_output(input2->outputs, c);
  reactor_add_cell(r, c);
  return c;
}

int get_cell_value(struct cell *c) { return c->value; }

void set_cell_value(struct cell *c, int new_value) {
  c->value = new_value;
  cell_update_value(c);
  cell_callback(c);
}

callback_id add_callback(cell_t *c, void *cbinfo, callback cb) {
  callback_data_t *callback = malloc(sizeof(callback_data_t));
  if (callback == NULL) {
    return -1;
  }
  callback->info = cbinfo;
  callback->func = cb;
  callback->id = c->num_of_callbacks;
  callback->next = c->callbacks;
  callback->value = c->value;
  c->callbacks = callback;
  c->num_of_callbacks++;
  return callback->id;
}

void remove_callback(cell_t *c, callback_id cid) {
  struct callback_data *curr = c->callbacks;
  struct callback_data *prev = NULL;
  while (curr != NULL) {
    if (curr->id == cid) {
      break;
    }
    prev = curr;
    curr = curr->next;
  }
  if (curr == NULL) {
    return;
  }

  if (prev == NULL) {
    c->callbacks = curr->next;
  } else {
    prev->next = curr->next;
  }
  free(curr);
}

void reactor_add_cell(reactor_t *r, cell_t *c) {
  if (r->head == NULL) {
    r->head = c;
    r->tail = c;
  } else {
    r->tail->next = c;
    r->tail = c;
  }
}

void reactor_add_output(reactor_t *r, cell_t *c) {
  if (r->head == NULL) {
    r->head = c;
    r->tail = c;
  } else {
    r->tail->output_chain = c;
    r->tail = c;
  }
}

void cell_update_value(cell_t *c) {
  if (c->type != INPUT) {
    int prev_value = c->value;
    int new_value = cell_compute_value(c);
    if (new_value == prev_value) {
      return;
    }
  }

  cell_t *curr = c->outputs->head;
  while (curr != NULL) {
    cell_update_value(curr);
    curr = curr->output_chain;
  }
}

int cell_compute_value(cell_t *c) {
  if (c->type == COMPUTE1) {
    c->value = c->compute.func1(c->input1->value);
  } else if (c->type == COMPUTE2) {
    c->value = c->compute.func2(c->input1->value, c->input2->value);
  }
  return c->value;
}

void cell_callback(cell_t *c) {
  if (c->type != INPUT) {
    callback_data_t *callback = c->callbacks;
    while (callback) {
      if (callback->func) {
        if (c->value == callback->value) {
          return;
        }
        callback->func(callback->info, c->value);
        callback->value = c->value;
      }
      callback = callback->next;
    }
  }

  cell_t *curr = c->outputs->head;
  while (curr != NULL) {
    cell_callback(curr);
    curr = curr->output_chain;
  }
}
