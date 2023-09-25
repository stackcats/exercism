class PascalsTriangle {
  List<List<int>> rows(int r) {
    if (r <= 0) {
      return [];
    }

    if (r == 1) {
      return [
        [1]
      ];
    }

    List<List<int>> res = [
      [1]
    ];

    for (int i = 1; i < r; i++) {
      res.add([1]);
      for (int j = 1; j < res[i - 1].length; j++) {
        res[i].add(res[i - 1][j - 1] + res[i - 1][j]);
      }
      res[i].add(1);
    }
    return res;
  }
}
