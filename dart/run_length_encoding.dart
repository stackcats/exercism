class RunLengthEncoder {
  String encode(String input) {
    String s = '';
    int ct = 1;
    String pre = '';
    for (int i = 0; i < input.length; i++) {
      if (pre == input[i]) {
        ct++;
      } else {
        if (ct > 1) {
          s += '$ct';
        }
        s += '$pre';
        ct = 1;
        pre = input[i];
      }
    }
    if (ct > 1) {
      s += '$ct';
    }
    s += '$pre';
    return s;
  }

  String decode(String input) {
    int ct = 0;
    String s = '';
    for (int i = 0; i < input.length; i++) {
      final n = int.tryParse(input[i]);
      if (n == null) {
        while (ct > 1) {
          s += input[i];
          ct--;
        }
        s += input[i];
        ct = 0;
      } else {
        ct = ct * 10 + n;
      }
    }
    return s;
  }
}
