def aux(text):
    vowels = 'aeiou'

    # Rule 1
    if text[0] in vowels:
        return text
    if text[:2] in ('xr', 'yt'):
        return text

    # Rule 3
    i = text.find('qu')
    if i != -1:
        return text[i+2:] + text[:i+2]

    # Rule 2, 4
    i = 0
    while text[i] not in vowels:
        if i > 0 and text[i] == 'y':
            break
        i += 1
        
    return text[i:] + text[:i]


def translate(text):
    arr = text.split(' ')
    return ' '.join([aux(s) + 'ay' for s in arr])
