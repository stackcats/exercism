enum Plant {
  radishes,
  clover,
  violets,
  grass,
}

enum Student {
  Alice,
  Bob,
  Charlie,
  David,
  Eve,
  Fred,
  Ginny,
  Harriet,
  Ileana,
  Joseph,
  Kincaid,
  Larry,
}

class KindergartenGarden {
  List<List<Plant>> garden = [];
  KindergartenGarden(String diagram) {
    final lst = diagram.split("\n");
    for (final row in lst) {
      final t = <Plant>[];
      row.runes.forEach((c) {
        switch (String.fromCharCode(c)) {
          case "V":
            t.add(Plant.violets);
          case "C":
            t.add(Plant.clover);
          case "G":
            t.add(Plant.grass);
          case "R":
            t.add(Plant.radishes);
        }
      });
      garden.add(t);
    }
    print(garden);
  }
  List<Plant> plants(Student stu) {
    final i = stu.index * 2;
    return [garden[0][i], garden[0][i + 1], garden[1][i], garden[1][i + 1]];
  }
}
