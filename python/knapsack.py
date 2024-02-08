def maximum_value(maximum_weight, items):
    dp = [0] * (maximum_weight + 1)
    for item in items:
        for i in range(maximum_weight, item["weight"] - 1, -1):
            dp[i] = max(dp[i - item["weight"]] + item["value"], dp[i])

    return dp[maximum_weight]
