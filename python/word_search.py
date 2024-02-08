class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y


class WordSearch:
    def __init__(self, puzzle):
        self.puzzle = puzzle

    def search(self, word):
        row = len(self.puzzle)
        col = len(self.puzzle[0])
        word_len = len(word)
        for i in range(row):
            for j in range(col):
                if self.puzzle[i][j] != word[0]:
                    continue
                arr = [
                    (-1, -1),
                    (-1, 0),
                    (-1, 1),
                    (0, 1),
                    (1, 1),
                    (1, 0),
                    (1, -1),
                    (0, -1),
                ]
                for k in range(1, word_len):
                    new_arr = []
                    for dx, dy in arr:
                        nx = i + dx * k
                        ny = j + dy * k
                        if (
                            nx >= 0
                            and ny >= 0
                            and nx < row
                            and ny < col
                            and self.puzzle[nx][ny] == word[k]
                        ):
                            new_arr.append((dx, dy))
                    arr = new_arr
                if arr != []:
                    dx, dy = arr[0]
                    return Point(j, i), Point(
                        j + dy * (word_len - 1), i + dx * (word_len - 1)
                    )
