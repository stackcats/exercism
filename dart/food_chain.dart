class FoodChain {
  List<String> recite(int start, int end) {
    final lst = <String>[];
    for (int i = start; i <= end; i++) {
      if (i > start) {
        lst.add('');
      }
      lst.addAll(verse(i));
    }
    return lst;
  }

  List<String> verse(int v) {
    v--;
    final foods = [
      'fly',
      'spider',
      'bird',
      'cat',
      'dog',
      'goat',
      'cow',
      'horse'
    ];
    final mp = {
      'spider': 'It wriggled and jiggled and tickled inside her.',
      'bird': 'How absurd to swallow a bird!',
      'cat': 'Imagine that, to swallow a cat!',
      'dog': 'What a hog, to swallow a dog!',
      'goat': 'Just opened her throat and swallowed a goat!',
      'cow': "I don't know how she swallowed a cow!",
      'horse': "She's dead, of course!",
    };

    final lst = <String>[];

    lst.add('I know an old lady who swallowed a ${foods[v]}.');
    if (mp[foods[v]] != null) {
      lst.add(mp[foods[v]]!);
    }

    if (foods[v] == 'horse') {
      return lst;
    }

    while (v > 0) {
      if (foods[v - 1] == 'spider') {
        lst.add(
            'She swallowed the ${foods[v]} to catch the ${foods[v - 1]} that wriggled and jiggled and tickled inside her.');
      } else {
        lst.add('She swallowed the ${foods[v]} to catch the ${foods[v - 1]}.');
      }
      v--;
    }

    lst.add("I don't know why she swallowed the fly. Perhaps she'll die.");

    return lst;
  }
}
