def classify(number):
    """ A perfect number equals the sum of its positive divisors.

    :param number: int a positive integer
    :return: str the classification of the input integer
    """
    if number <= 0:
        raise ValueError('Classification is only possible for positive integers.')
    lst = [i for i in range(1, number) if number % i == 0]
    sum_ = sum(lst)
    if sum_ == number:
        return 'perfect'
    if sum_ > number:
        return 'abundant'
    return 'deficient'
