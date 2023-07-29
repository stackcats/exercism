from collections import deque


def check_o(board):
    r = len(board)
    for j in range(r):
        if board[0][j] != 'O':
            continue
        q = deque([(0, j)])
        visited = set()
        while len(q) != 0:
            (x, y) = q.popleft()
            if (x, y) in visited:
                continue
            visited.add((x, y))
            if x == r - 1:
                return True
            for (dx, dy) in [(0, -2), (1, -1), (1, 1), (0, 2), (-1, -1),
                             (-1, 1)]:
                nx = x + dx
                ny = y + dy
                if nx < r and ny >= 0 and ny < len(
                        board[nx]) and board[nx][ny] == 'O':
                    q.append((nx, ny))

    return False


def check_x(board):
    r = len(board)
    j = -1
    for i in range(r):
        j += 1
        if board[i][j] != 'X':
            continue
        q = deque([(i, j)])
        visited = set()
        while len(q) != 0:
            (x, y) = q.popleft()
            if (x, y) in visited:
                continue
            visited.add((x, y))
            if y == r + j - 1:
                return True
            for (dx, dy) in [(0, -2), (1, -1), (1, 1), (0, 2), (-1, -1),
                             (-1, 1)]:
                nx = x + dx
                ny = y + dy
                if nx < r and ny >= 0 and ny < len(
                        board[nx]) and board[nx][ny] == 'X':
                    q.append((nx, ny))

    return False


def padding_board(board):
    r = len(board)
    for i in range(r):
        board[i] = ' ' * i + board[i]


class ConnectGame:

    def __init__(self, board):
        board = [line.strip() for line in board.split('\n')]
        padding_board(board)
        if check_o(board):
            self.winner = 'O'
        elif check_x(board):
            self.winner = 'X'
        else:
            self.winner = ''

    def get_winner(self):
        return self.winner
