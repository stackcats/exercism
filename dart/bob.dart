class Bob {
  String response(String input) {
    input = input.trim();
    bool is_question = input.endsWith('?');
    bool is_yelling =
        RegExp(r'[A-Za-z]').hasMatch(input) && input.toUpperCase() == input;
    bool is_yelling_question = is_question && is_yelling;
    bool is_silence = input == '';

    if (is_yelling_question) {
      return "Calm down, I know what I'm doing!";
    }

    if (is_question) {
      return "Sure.";
    }

    if (is_yelling) {
      return "Whoa, chill out!";
    }

    if (is_silence) {
      return "Fine. Be that way!";
    }

    return "Whatever.";
  }
}
