def diff(c1, c2):
    return ord(c1) - ord(c2)

def row(ch, outer_len):
    outer = ' ' * outer_len
    if ch == 'A':
        return f'{outer}{ch}{outer}'

    inner_len = diff(ch, 'A')
    inner = ' ' * (inner_len * 2 - 1)
    return f'{outer}{ch}{inner}{ch}{outer}'
    
def rows(letter):
    if letter == 'A':
        return ['A']

    res = []

    ch = 'A'
    outer_len = diff(letter, 'A')
    
    while ch < letter:
        res.append(row(ch, outer_len))
        ch = chr(ord(ch) + 1)
        outer_len -= 1
    
    while ch >= 'A':
        res.append(row(ch, outer_len))
        ch = chr(ord(ch) - 1)
        outer_len += 1
        
    return res

