from functools import reduce


def rebase(input_base, digits, output_base):
    if input_base < 2:
        raise ValueError("input base must be >= 2")

    if output_base < 2:
        raise ValueError("output base must be >= 2")

    if any([True for d in digits if d < 0 or d >= input_base]):
        raise ValueError("all digits must satisfy 0 <= d < input base")

    n = reduce(lambda x, y: x * input_base + y, digits, 0)

    if n == 0:
        return [0]
    
    output_digits = []
    while n != 0:
        output_digits.append(n % output_base)
        n //= output_base

    return output_digits[::-1]
    
