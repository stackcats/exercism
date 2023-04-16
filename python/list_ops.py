def append(list1, list2):
    for x in list2:
        list1.append(x)
    return list1


def concat(lists):
    if lists == []:
        return []
    x, *xs = lists
    for y in xs:
        x = append(x, y)
    return x


def filter(function, list):
    return [x for x in list if function(x)]


def length(list):
    if list == []:
        return 0
    _, *xs = list
    return 1 + length(xs)


def map(function, list):
    return [function(x) for x in list]


def foldl(function, list, initial):
    for x in list:
        initial = function(initial, x)
    return initial


def foldr(function, list, initial):
    if list == []:
        return initial
    x, *xs = list
    return function(x, foldr(function, xs, initial))


def reverse(list):
    if list == []:
        return []
    x, *xs = list
    xs = reverse(xs)
    append(xs, [x])
    return xs
