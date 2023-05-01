def find_fewest_coins(coins, target):
    if target < 0:
        raise ValueError("target can't be negative")

    if target == 0:
        return []

    dp = [target + 1] * (target + 1)
    dp[0] = 0

    changed_coins = [[] for _ in range(target + 1)]

    for amount in range(1, target + 1):
        for c in coins:
            if amount - c >= 0:
                if dp[amount - c] + 1 < dp[amount]:
                    dp[amount] = dp[amount - c] + 1
                    changed_coins[amount] = changed_coins[amount - c][:] + [c]

    if not changed_coins[target]:
        raise ValueError("can't make target with given coins")

    return sorted(changed_coins[target])
