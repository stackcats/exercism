class Minesweeper {
  List<String> annotated = [];
  Minesweeper(List<String> mp) {
    List<List<String>> grid = mp.map((e) => e.split('')).toList();
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        if (grid[i][j] == '*') {
          continue;
        }

        List<List<int>> neighbors = [
          [-1, -1],
          [-1, 0],
          [-1, 1],
          [0, 1],
          [1, 1],
          [1, 0],
          [1, -1],
          [0, -1],
        ];

        int ct = 0;
        for (final arr in neighbors) {
          int nx = i + arr[0];
          int ny = j + arr[1];
          if (nx >= 0 &&
              ny >= 0 &&
              nx < grid.length &&
              ny < grid[i].length &&
              grid[nx][ny] == '*') {
            ct++;
          }
        }
        if (ct > 0) {
          grid[i][j] = '$ct';
        }
      }
    }

    annotated = grid.map((r) => r.join('')).toList();
  }
}
