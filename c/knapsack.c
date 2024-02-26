#include "knapsack.h"
#include <stdlib.h>
#include <string.h>

#define max(x, y) (((x) > (y)) ? (x) : (y))

unsigned int maximum_value(unsigned int maximum_weight, const item_t *items,
                           size_t item_count) {
  unsigned int *dp = malloc(sizeof(unsigned int) * (maximum_weight + 1));
  memset(dp, 0, sizeof(unsigned int) * (maximum_weight + 1));

  for (size_t i = 0; i < item_count; i++) {
    for (unsigned int j = maximum_weight; j >= items[i].weight; j--) {
      dp[j] = max(dp[j], dp[j - items[i].weight] + items[i].value);
    }
  }

  unsigned int ans = dp[maximum_weight];

  free(dp);

  return ans;
}
