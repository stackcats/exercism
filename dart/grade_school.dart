typedef Student = Function(dynamic int, dynamic String);

class GradeSchool {
  final Map<String, int> students = {};

  List<bool> add(List<(String, int)> arr) {
    final List<bool> res = [];
    for (final (n, g) in arr) {
      if (students.containsKey(n)) {
        res.add(false);
        continue;
      }
      students[n] = g;
      res.add(true);
    }
    return res;
  }

  List<String> roster() {
    final lst = students.keys.toList();
    lst.sort((a, b) {
      if (students[a] == students[b]) {
        return a.compareTo(b);
      }
      return students[a]!.compareTo(students[b]!);
    });
    return lst;
  }

  List<String> grade(int g) {
    final lst = students.entries
        .where((each) => each.value == g)
        .map((each) => each.key)
        .toList();
    lst.sort();
    return lst;
  }
}
