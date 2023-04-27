import re


def encode_char(c):
    if '0' <= c <= '9':
        return c
    else:
        return chr(ord('a') + ord('z') - ord(c))


def encode(plain_text):
    encoded = plain_text.lower()
    encoded = re.sub(r'[^a-z0-9]', '', encoded)
    encoded = ''.join([encode_char(c) for c in encoded])
    res = []
    for i in range(0, len(encoded), 5):
        res.append(encoded[i:i + 5])
    return ' '.join(res)


def decode(ciphered_text):
    decoded = ciphered_text.replace(' ', '')
    return ''.join([encode_char(c) for c in decoded])
