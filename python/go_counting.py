from collections import defaultdict

WHITE = 0
BLACK = 1
NONE = 2


class UnionFind:
    def __init__(self):
        self.root = {}
        self.rank = defaultdict(int)

    def find(self, k):
        if k not in self.root:
            self.root[k] = k
            return k

        root = self.root[k]
        if root == k:
            return k
        root = self.find(root)
        self.root[k] = root
        return root

    def union(self, a, b):
        ra = self.find(a)
        rb = self.find(b)
        if ra == rb:
            return

        if self.rank[ra] < self.rank[rb]:
            self.root[ra] = rb
        elif self.rank[ra] > self.rank[rb]:
            self.root[rb] = ra
        else:
            self.root[rb] = ra
            self.rank[ra] += 1

    def to_groups(self):
        groups = defaultdict(set)
        for k, root in self.root.items():
            groups[root].add(k)
        return groups


class Board:
    def __init__(self, board):
        self.board = board
        self.uf = UnionFind()
        self.row = len(board)
        self.col = len(board[0])
        for i in range(self.row):
            for j in range(self.col):
                if board[i][j] != " ":
                    continue
                if i > 0 and board[i - 1][j] == " ":
                    self.uf.union((j, i - 1), (j, i))
                if j > 0 and board[i][j - 1] == " ":
                    self.uf.union((j - 1, i), (j, i))
                self.uf.union((j, i), (j, i))
        self.groups = self.uf.to_groups()
        self.border = {}
        self.check_border()

    def check_border(self):
        dir = [(-1, 0), (1, 0), (0, 1), (0, -1)]
        for k, g in self.groups.items():
            isblack = False
            iswhite = False
            for j, i in g:
                for dj, di in dir:
                    ni = i + di
                    nj = j + dj
                    if not self.is_valid_coor(ni, nj):
                        continue
                    if self.board[ni][nj] == "B":
                        isblack = True
                    elif self.board[ni][nj] == "W":
                        iswhite = True

            if isblack and not iswhite:
                self.border[k] = BLACK
            elif iswhite and not isblack:
                self.border[k] = WHITE
            else:
                self.border[k] = NONE

    def is_valid_coor(self, i, j):
        return i >= 0 and i < self.row and j >= 0 and j < self.col

    def territory(self, x, y):
        if not self.is_valid_coor(y, x):
            raise ValueError("Invalid coordinate")

        if self.board[y][x] != " ":
            return NONE, set()

        root = self.uf.find((x, y))

        return self.border[root], self.groups[root]

    def territories(self):
        territories = defaultdict(set)
        for k, v in self.border.items():
            territories[v] |= self.groups[k]
        return territories
