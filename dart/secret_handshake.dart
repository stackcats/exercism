class SecretHandshake {
  List<String> commands(int code) {
    List<String> res = [];
    if (code & 1 == 1) res.add("wink");
    if (code & 2 == 2) res.add("double blink");
    if (code & 4 == 4) res.add("close your eyes");
    if (code & 8 == 8) res.add("jump");
    if (code & 16 == 16) res = res.reversed.toList();
    return res;
  }
}
