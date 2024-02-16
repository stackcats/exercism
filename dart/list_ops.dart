extension ListOps on List {
  void append<T>(List<T> other) {
    for (final each in other) {
      this.add(each);
    }
  }

  List<T> concat<T>() {
    final List<T> arr = [];
    for (final each in this) {
      arr.addAll(each);
    }
    return arr;
  }

  List<T> filter<T>(bool Function(T elem) predicate) {
    final List<T> arr = [];
    for (final each in this) {
      if (predicate(each)) {
        arr.add(each);
      }
    }
    return arr;
  }

  int count() {
    return this.length;
  }

  List<T> myMap<T>(T Function(T elem) fn) {
    final List<T> arr = [];
    for (final each in this) {
      arr.add(fn(each));
    }
    return arr;
  }

  U foldl<T, U>(U initial, U Function(U acc, T elem) fn) {
    for (final each in this) {
      initial = fn(initial, each);
    }
    return initial;
  }

  U foldr<T, U>(U initial, U Function(T elem, U acc) fn) {
    for (final each in this.reversed) {
      initial = fn(each, initial);
    }
    return initial;
  }

  List<T> reverse<T>() {
    final List<T> arr = [];
    for (final each in this.reversed) {
      arr.add(each);
    }
    return arr;
  }
}
