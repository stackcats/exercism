class Meetup {
  static const mp = <String, int>{
    'Monday': 1,
    'Tuesday': 2,
    'Wednesday': 3,
    'Thursday': 4,
    'Friday': 5,
    'Saturday': 6,
    'Sunday': 7,
  };

  String meetup(
      {required int year,
      required int month,
      required String week,
      required String dayofweek}) {
    var dt = DateTime.utc(year, month, 1);
    final arr = <DateTime>[];
    while (dt.month == month) {
      if (dt.weekday == mp[dayofweek]) {
        arr.add(dt);
      }
      dt = dt.add(Duration(days: 1));
    }

    final indices = ['first', 'second', 'third', 'fourth'];

    if (indices.contains(week)) {
      return format(arr[indices.indexOf(week)]);
    }

    if (week == "last") {
      return format(arr.last);
    }

    for (final dt in arr) {
      if (dt.day >= 13) {
        return format(dt);
      }
    }

    throw 'unreachable';
  }

  String format(DateTime dt) {
    return "${dt.year}-${two_digits(dt.month)}-${two_digits(dt.day)}";
  }

  String two_digits(int n) {
    return n.toString().padLeft(2, '0');
  }
}
