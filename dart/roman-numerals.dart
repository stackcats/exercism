extension ConvertToRomanNumerals on int {
  String toRoman() {
    final romans = [
      "M",
      "CM",
      "D",
      "CD",
      "C",
      "XC",
      "L",
      "XL",
      "X",
      "IX",
      "V",
      "IV",
      "I"
    ];
    final nums = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    String s = "";
    int n = this;
    for (int i = 0; i < romans.length; i++) {
      while (n >= nums[i]) {
        s += romans[i];
        n -= nums[i];
      }
    }
    return s;
  }
}
