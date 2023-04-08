def average(a, b):
    return (a + b) / 2


def is_good_enough(root, number):
    return abs(root * root - number) < 0.001


def improve(root, number):
    return average(root, number / root)


def square_root(number):
    root = 1
    
    while not is_good_enough(root, number):
        root = improve(root, number)

    return int(root)
