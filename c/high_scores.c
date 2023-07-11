#include "high_scores.h"

#include <math.h>
#include <stddef.h>

#define SWAP(x, y, T)                                                          \
  do {                                                                         \
    T SWAP = x;                                                                \
    x = y;                                                                     \
    y = SWAP;                                                                  \
  } while (0)

int32_t latest(const int32_t *scores, size_t scores_len) {
  return scores[scores_len - 1];
}

/// Return the highest score.
int32_t personal_best(const int32_t *scores, size_t scores_len) {
  int32_t target = scores[0];
  for (size_t i = 1; i < scores_len; i++) {
    target = fmax(target, scores[i]);
  }
  return target;
}

/// Write the highest scores to `output` (in non-ascending order).
/// Return the number of scores written.
size_t personal_top_three(const int32_t *scores, size_t scores_len,
                          int32_t *output) {
  output[0] = output[1] = output[2] = 0;
  for (size_t i = 0; i < scores_len; i++) {
    int32_t score = scores[i];
    if (score > output[0]) {
      SWAP(output[0], score, int32_t);
    }
    if (score > output[1]) {
      SWAP(output[1], score, int32_t);
    }
    if (score > output[2]) {
      SWAP(output[2], score, int32_t);
    }
  }
  return fmin(3, scores_len);
}
