def grep(pattern, flags, files):
    [n, i, l, x, v] = [x in flags for x in ['-n', '-i', '-l', '-x', '-v']]

    m = len(files) > 1

    pattern = i and pattern.lower() or pattern

    res = []
    for file in files:
        for ln_num, line in enumerate(open(file).readlines()):
            line_i = i and line.lower() or line
            if v ^ (not x and pattern in line_i or f'{pattern}\n' == line_i):
                if l:
                    res.append(f'{file}\n')
                    break

                matched = ''

                if m:
                    matched += f'{file}:'

                if n:
                    matched += f'{ln_num+1}:'

                matched += line

                res.append(matched)

    return ''.join(res)
