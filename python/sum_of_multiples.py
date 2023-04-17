def sum_of_multiples(limit, multiples):
    st = set()
    for n in multiples:
        if n == 0:
            continue
        for m in range(n, limit, n):
            st.add(m)
    return sum(st)
