import re


def abbreviate(words):
    lst = re.sub(r'[^- a-zA-Z0-9]', '', words).replace('-',
                                                       ' ').upper().split(' ')
    return ''.join([w[0] for w in lst if w])
