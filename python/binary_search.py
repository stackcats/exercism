def find(search_list, value):
    if search_list == []:
        raise ValueError('value not in array')
    l = 0
    r = len(search_list) - 1
    while l <= r:
        mid = (l + r) // 2
        if search_list[mid] == value:
            return mid
        if search_list[mid] < value:
            l = mid + 1
        else:
            r = mid - 1
    raise ValueError('value not in array')
