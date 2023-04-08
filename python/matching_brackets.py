def is_paired(input_string):
    st = []
    pairs = {')': '(', ']': '[', '}': '{'}
    for c in input_string:
        if c in '([{':
            st.append(c)
        elif c in pairs:
            if len(st) > 0 and st[-1] == pairs[c]:
                st.pop()
            else:
                return False

    return len(st) == 0
