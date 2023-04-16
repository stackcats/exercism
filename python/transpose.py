def transpose(lines):
    lines = lines.split("\n")
    pad = max(len(t) for t in lines)
    lines = [t.ljust(pad) for t in lines]
    res = [''.join(L) for L in zip(*lines)]

    pad = 0
    for i in range(len(res) - 1, -1, -1):
        res[i] = res[i].rstrip().ljust(pad)
        pad = max(pad, len(res[i]))

    return '\n'.join(res)
