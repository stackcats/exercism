class Acronym {
  String abbreviate(String s) {
    return s
        .replaceAll('-', ' ')
        .split(' ')
        .where((w) => w.trim().isNotEmpty)
        .map((w) => w.replaceAll(RegExp(r'[^a-zA-Z]'), '').toUpperCase()[0])
        .join();
  }
}
