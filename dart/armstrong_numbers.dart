class ArmstrongNumbers {
  bool isArmstrongNumber(String s) {
    BigInt m = BigInt.from(0);
    s.runes.forEach((c) {
      BigInt n = BigInt.parse(String.fromCharCode(c));
      m += n.pow(s.length);
    });
    return m == BigInt.parse(s);
  }
}
