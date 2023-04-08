def rotate(text, key):
    encoded = ''
    for c in text:
        if c.isalpha():
            code = ord(c)
            base = ord(c.isupper() and 'A' or 'a')
            encoded += chr((code - base + key) % 26 + base)
        else:
            encoded += c
    return encoded
