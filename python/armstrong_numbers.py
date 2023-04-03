def number_to_list(number):
    lst = []
    while number > 0:
        lst.append(number % 10)
        number //= 10
    return lst


def is_armstrong_number(number):
    lst = number_to_list(number)
    p = len(lst)
    return sum(d ** p for d in lst) == number
