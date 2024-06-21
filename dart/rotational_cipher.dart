class RotationalCipher {
  String rotate({required String text, required int shiftKey}) {
    return text.runes
        .map((c) => String.fromCharCode(shift(c, shiftKey)))
        .join('');
  }

  int shift(int c, int shiftKey) {
    const a = 65;
    const A = 97;

    switch (c) {
      case >= a && < a + 26:
        return (c - a + shiftKey) % 26 + a;
      case >= A && < A + 26:
        return (c - A + shiftKey) % 26 + A;
    }
    return c;
  }
}
