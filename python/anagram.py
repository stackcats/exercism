from collections import Counter


def find_anagrams(word, candidates):
    ct = Counter(word.lower())
    return [
        x for x in candidates
        if Counter(x.lower()) == ct and x.lower() != word.lower()
    ]
