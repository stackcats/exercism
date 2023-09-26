class PhoneNumber {
  String clean(String number) {
    if (RegExp(r'[a-zA-Z]').hasMatch(number)) {
      throw FormatException('letters not permitted');
    }

    if (RegExp(r'[^-+\s.()0-9]').hasMatch(number)) {
      throw FormatException('punctuations not permitted');
    }

    number = number.replaceAll(RegExp(r'[^0-9]'), '');

    if (number.length > 11) {
      throw FormatException('more than 11 digits');
    }

    if (number.length == 11) {
      if (number[0] != '1') {
        throw FormatException('11 digits must start with 1');
      }
      number = number.substring(1);
    }

    if (number.length != 10) {
      throw FormatException('incorrect number of digits');
    }

    if (number[0] == '0') {
      throw FormatException('area code cannot start with zero');
    }

    if (number[0] == '1') {
      throw FormatException('area code cannot start with one');
    }

    if (number[3] == '0') {
      throw FormatException('exchange code cannot start with zero');
    }

    if (number[3] == '1') {
      throw FormatException('exchange code cannot start with one');
    }

    return number;
  }
}
