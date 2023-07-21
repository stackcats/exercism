def is_prime(n: int) -> bool:
    if n < 2:
        return False
    if n == 2:
        return True

    m = round(n**0.5) + 1
    for i in range(2, m):
        if n % i == 0:
            return False
    return True


def prime(number: int) -> int:
    if number == 0:
        raise ValueError('there is no zeroth prime')
    n = 1
    while number > 0:
        n += 1
        if is_prime(n):
            number -= 1
    return n
