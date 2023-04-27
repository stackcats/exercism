NUMBER_MAP = {
    0: '',
    1: 'one',
    2: 'two',
    3: 'three',
    4: 'four',
    5: 'five',
    6: 'six',
    7: 'seven',
    8: 'eight',
    9: 'nine',
    10: 'ten',
    11: 'eleven',
    12: 'twelve',
    13: 'thirteen',
    14: 'fourteen',
    15: 'fifteen',
    16: 'sixteen',
    17: 'seventeen',
    18: 'eighteen',
    19: 'nineteen',
    20: 'twenty',
    30: 'thirty',
    40: 'forty',
    50: 'fifty',
    60: 'sixty',
    70: 'seventy',
    80: 'eighty',
    90: 'ninety',
}


def aux(number):
    div = number // 100
    number = number % 100
    said = []
    if div > 0:
        said.append(f'{NUMBER_MAP[div]} hundred')

    if number == 0:
        return ''.join(said)

    if number in NUMBER_MAP:
        said.append(f'{NUMBER_MAP[number]}')
    else:
        rem = number % 10
        number = number - rem
        if rem == 0:
            said.append(f'{NUMBER_MAP[number]}')
        else:
            said.append(f'{NUMBER_MAP[number]}-{NUMBER_MAP[rem]}')

    return ' '.join(said)


def say(number):
    if number < 0 or number > 999_999_999_999:
        raise ValueError('input out of range')

    if number == 0:
        return 'zero'

    said = []
    div = number // 1000000000
    number = number % 1000000000

    if div > 0:
        said.append(f'{aux(div)} billion')

    div = number // 1000000
    number = number % 1000000
    if div > 0:
        said.append(f'{aux(div)} million')

    div = number // 1000
    number = number % 1000
    if div > 0:
        said.append(f'{aux(div)} thousand')

    said.append(f'{aux(number)}')

    return ' '.join([r for r in said if r != ''])
