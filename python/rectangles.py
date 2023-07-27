from itertools import permutations


def horizontal_path(strings, a, b) -> bool:
    (x1, y1) = a
    (_, y2) = b
    for y in range(y1, y2 + 1):
        if strings[x1][y] not in ['+', '-']:
            return False
    return True


def vertical_path(strings, a, b) -> bool:
    (x1, y1) = a
    (x2, _) = b
    for x in range(x1, x2 + 1):
        if strings[x][y1] not in ['+', '|']:
            return False
    return True


def rectangles(strings: list[str]) -> int:
    corners = []
    for (i, s) in enumerate(strings):
        for (j, c) in enumerate(s):
            if c == '+':
                corners.append((i, j))

    if len(corners) < 4:
        return 0

    perm = permutations(corners, 4)
    st = set()
    for points in perm:
        # a: top-left, b: top-right, c: bottom-left, d: bottom-right
        [a, b, c, d] = sorted(points)
        if a[0] == b[0] and a[1] == c[1] and b[1] == d[1] and c[0] == d[
                0] and horizontal_path(strings, a, b) and horizontal_path(
                    strings, c, d) and vertical_path(
                        strings, a, c) and vertical_path(strings, b, d):
            st.add((a, b, c, d))

    return len(st)
