def is_pangram(sentence):
    st = set(sentence.lower())
    for c in 'abcdefghijklmnopqrstuvwxyz':
        if c not in st:
            return False
    return True
