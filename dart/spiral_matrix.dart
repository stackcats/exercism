class SpiralMatrix {
  final int size;

  SpiralMatrix(this.size);

  List<List<int>> toList() {
    final List<List<int>> lst =
        List.generate(size, (_) => List.generate(size, (_) => 0));
    int i = 0;
    int j = 0;
    int di = 0;
    int dj = 1;
    int k = 1;
    while (k <= size * size) {
      lst[i][j] = k;
      final ni = i + di;
      final nj = j + dj;
      if (ni < 0 || ni >= size || nj < 0 || nj >= size || lst[ni][nj] != 0) {
        final t = di;
        di = dj;
        dj = -t;
      }
      i += di;
      j += dj;
      k++;
    }
    return lst;
  }
}
