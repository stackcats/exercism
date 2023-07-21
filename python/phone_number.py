import re


class PhoneNumber:

    def __init__(self, number):
        if re.search(r'[a-zA-Z]', number):
            raise ValueError('letters not permitted')

        if re.search(r'[@:!]', number):
            raise ValueError('punctuations not permitted')

        number = re.sub(r'[^0-9]', '', number)

        if len(number) > 11:
            raise ValueError('must not be greater than 11 digits')

        if len(number) == 11:
            if number[0] != '1':
                raise ValueError('11 digits must start with 1')

            number = number[1:]

        if len(number) != 10:
            raise ValueError('must not be fewer than 10 digits')

        if (number[0] == '0'):
            raise ValueError('area code cannot start with zero')
        if (number[0] == '1'):
            raise ValueError('area code cannot start with one')

        self.number = number

        self.area_code = number[:3]

        self.exchange_code = number[3:6]
        if self.exchange_code[0] == '0':
            raise ValueError('exchange code cannot start with zero')
        if self.exchange_code[0] == '1':
            raise ValueError('exchange code cannot start with one')

        self.subscriber_number = number[6:]

    def pretty(self):
        return f'({self.area_code})-{self.exchange_code}-{self.subscriber_number}'
