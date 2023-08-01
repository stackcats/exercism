def largest(min_factor, max_factor):
    if min_factor > max_factor:
        raise ValueError('min must be <= max')

    start = max_factor * max_factor
    end = min_factor * min_factor
    for x in range(start, end - 1, -1):
        if is_palindrome(x):
            factors = find_factors(x, min_factor, max_factor)
            if factors != []:
                return x, factors

    return None, []


def smallest(min_factor, max_factor):
    if min_factor > max_factor:
        raise ValueError('min must be <= max')

    start = min_factor * min_factor
    end = max_factor * max_factor

    for x in range(start, end + 1):
        if is_palindrome(x):
            factors = find_factors(x, min_factor, max_factor)
            if factors != []:
                return x, factors

    return None, []


def find_factors(value, min_factor, max_factor):
    factors = []
    for a in range(min_factor, round(value**0.5) + 1):
        if value % a == 0:
            b = value // a
            if b >= min_factor and b <= max_factor:
                factors.append([a, b])
    return factors


def is_palindrome(c):
    s = str(c)
    return s == s[::-1]
