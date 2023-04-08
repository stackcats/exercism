from collections import defaultdict

def is_isogram(string):
    dt = defaultdict(int)
    for c in string.lower():
        dt[c] += 1
    for k in dt:
        if k.isalpha() and dt[k] > 1:
            return False
    return True
