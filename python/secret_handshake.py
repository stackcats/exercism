def commands(binary_str: str) -> [str]:
    actions = ['jump', 'close your eyes', 'double blink', 'wink']
    res = [actions[i] for (i, b) in enumerate(binary_str[1:]) if b == '1']
    if binary_str[0] == '1':
        return res
    return res[::-1]
