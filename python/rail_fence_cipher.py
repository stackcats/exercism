def encode(message, rails):
    lst = ['' for _ in range(rails)]
    row = 0
    dx = 1
    for c in message:
        lst[row] += c
        if row + dx == -1:
            dx = 1
        elif row + dx == rails:
            dx = -1
        row += dx
    return ''.join(lst)


def decode(encoded_message, rails):
    prev = ''
    s = encoded_message
    while True:
        prev = s
        s = encode(s, rails)
        if s == encoded_message:
            break
    return prev
