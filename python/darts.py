def score(x, y):
    dis = (x * x + y * y) ** 0.5
    if dis > 10:
        return 0
    if dis > 5:
        return 1
    if dis > 1:
        return 5
    return 10
