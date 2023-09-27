class Forth {
  List<int> stack = [];
  Map<String, String> words = {};

  void defineWord(String word, List<String> commands) {
    int? val = int.tryParse(word);
    if (val != null) {
      throw Exception('Invalid definition');
    }
    for (int i = 0; i < commands.length; i++) {
      commands[i] = words[commands[i]] ?? commands[i];
    }
    words[word] = commands.join(' ');
  }

  void evaluate(String input) {
    final lst = input.toLowerCase().split(' ');

    if (lst[0] == ':') {
      defineWord(lst[1], lst.sublist(2, lst.length - 1));
      return;
    }

    for (int i = 0; i < lst.length; i++) {
      int? val = int.tryParse(lst[i]);
      if (val != null) {
        stack.add(val);
        continue;
      }

      if (words.containsKey(lst[i])) {
        evaluate(words[lst[i]]!);
        continue;
      }

      switch (lst[i]) {
        case '+':
          if (stack.length < 2) {
            throw Exception('Stack empty');
          }
          int a = stack.removeLast();
          int b = stack.removeLast();
          stack.add(a + b);
          break;
        case '-':
          if (stack.length < 2) {
            throw Exception('Stack empty');
          }
          int a = stack.removeLast();
          int b = stack.removeLast();
          stack.add(b - a);
          break;

        case '*':
          if (stack.length < 2) {
            throw Exception('Stack empty');
          }
          int a = stack.removeLast();
          int b = stack.removeLast();
          stack.add(b * a);
          break;

        case '/':
          if (stack.length < 2) {
            throw Exception('Stack empty');
          }
          int a = stack.removeLast();
          if (a == 0) {
            throw Exception('Division by zero');
          }
          int b = stack.removeLast();
          stack.add(b ~/ a);
          break;

        case 'dup':
          if (stack.length < 1) {
            throw Exception('Stack empty');
          }
          stack.add(stack.last);
          break;

        case 'drop':
          if (stack.length < 1) {
            throw Exception('Stack empty');
          }
          stack.removeLast();
          break;

        case 'swap':
          if (stack.length < 2) {
            throw Exception('Stack empty');
          }
          int a = stack.removeLast();
          int b = stack.removeLast();
          stack.add(a);
          stack.add(b);
          break;

        case 'over':
          if (stack.length < 2) {
            throw Exception('Stack empty');
          }
          int a = stack.removeLast();
          int b = stack.last;
          stack.add(a);
          stack.add(b);
          break;

        default:
          throw Exception('Unknown command');
      }
    }
  }
}
