import re


class StackUnderflowError(Exception):

    def __init__(self, message):
        self.message = message


def parse_user_defined(user_defined, data):
    arr = user_defined.split(' ')[1:-1]
    if re.match(r'-?\d+', arr[0]):
        raise ValueError('illegal operation')
    return data.replace(arr[0], ' '.join(arr[1:]))


def split_user_defined_and_data(input_data):
    i = 0
    while i < len(input_data) and input_data[i][0] == ':':
        i += 1
    if i >= len(input_data):
        return (input_data[:i], '')
    return (input_data[:i], input_data[i].lower())


def evaluate(input_data):
    user_defined_data, data = split_user_defined_and_data(input_data)

    for each in user_defined_data[::-1]:
        data = parse_user_defined(each.lower(), data)

    st = []

    for op in data.split(' '):
        if re.match(r'-?\d+', op):
            st.append(int(op))
        elif op == '+':
            if len(st) < 2:
                raise StackUnderflowError(
                    'Insufficient number of items in stack')
            b = st.pop()
            a = st.pop()
            st.append(a + b)
        elif op == '*':
            if len(st) < 2:
                raise StackUnderflowError(
                    'Insufficient number of items in stack')
            b = st.pop()
            a = st.pop()
            st.append(a * b)
        elif op == '/':
            if len(st) < 2:
                raise StackUnderflowError(
                    'Insufficient number of items in stack')
            b = st.pop()
            if b == 0:
                raise ZeroDivisionError('divide by zero')
            a = st.pop()
            st.append(a // b)
        elif op == '-':
            if len(st) < 2:
                raise StackUnderflowError(
                    'Insufficient number of items in stack')
            b = st.pop()
            a = st.pop()
            st.append(a - b)
        elif op == 'dup':
            if len(st) == 0:
                raise StackUnderflowError(
                    'Insufficient number of items in stack')
            st.append(st[-1])
        elif op == 'drop':
            if len(st) == 0:
                raise StackUnderflowError(
                    'Insufficient number of items in stack')
            st.pop()
        elif op == 'swap':
            if len(st) < 2:
                raise StackUnderflowError(
                    'Insufficient number of items in stack')
            b = st.pop()
            a = st.pop()
            st += [b, a]
        elif op == 'over':
            if len(st) < 2:
                raise StackUnderflowError(
                    'Insufficient number of items in stack')
            st.append(st[-2])
        else:
            raise ValueError('undefined operation')

    return st
