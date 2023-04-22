from collections import defaultdict


def count_words(sentence):
    words = defaultdict(int)
    word = ''
    sentence = list(sentence.lower())
    for (i, c) in enumerate(sentence):
        if c.isalnum():
            word += c
        elif c == '\'' and i > 0 and sentence[i - 1].isalnum(
        ) and i + 1 < len(sentence) and sentence[i + 1].isalnum():
            word += c
        else:
            words[word] += 1
            word = ''

    words[word] += 1

    if '' in words:
        words.pop('')

    return dict(words)
