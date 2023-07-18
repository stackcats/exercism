from collections import deque


def measure(bucket_one, bucket_two, goal, start_bucket):
    q = deque()
    q.append((0, 0, 0))
    st = set()
    while q:
        (b1, b2, ct) = q.popleft()
        if (b1, b2) in st:
            continue
        if (start_bucket == 'one'):
            if b1 == 0 and b2 == bucket_two:
                continue
        else:
            if b1 == bucket_one and b2 == 0:
                continue
        st.add((b1, b2))
        if b1 == goal:
            return (ct, 'one', b2)
        if b2 == goal:
            return (ct, 'two', b1)

        # 1 pouring 1 to 2
        diff = min(bucket_two - b2, b1)
        q.append((b1 - diff, b2 + diff, ct + 1))
        # 2 emptying 1
        q.append((0, b2, ct + 1))
        # 3 filling 1
        q.append((bucket_one, b2, ct + 1))
        # 4 pouring 2 to 1
        diff = min(bucket_one - b1, b2)
        q.append((b1 + diff, b2 - diff, ct + 1))
        # 5 emptying 2
        q.append((b1, 0, ct + 1))
        # 6 filling 2
        q.append((b1, bucket_two, ct + 1))

    raise ValueError('can not measure')
