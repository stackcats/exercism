import random
import string


def get_random_string(length):
    letters = string.ascii_lowercase
    return ''.join(random.choice(letters) for i in range(length))


class Cipher:

    def __init__(self, key=None):
        if key:
            self.key = key
        else:
            self.key = get_random_string(100)

    def encode(self, text: str) -> str:
        if not self.key:
            return text

        i = 0
        decoded = ''
        for c in text:
            diff = ord(self.key[i]) - ord('a')
            t = ord(c)
            while diff > 0:
                t += 1
                if t > ord('z'):
                    t = ord('a')
                diff -= 1
            decoded += chr(t)
            i = (i + 1) % len(self.key)

        return decoded

    def decode(self, text: str) -> str:
        if not self.key:
            return text

        i = 0
        encoded = ''
        for c in text:
            diff = ord(self.key[i]) - ord('a')
            t = ord(c)
            while diff > 0:
                t -= 1
                if t < ord('a'):
                    t = ord('z')
                diff -= 1
            encoded += chr(t)
            i = (i + 1) % len(self.key)

        return encoded
