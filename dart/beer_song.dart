class BeerSong {
  String aux(int i) {
    if (i == 0) {
      return 'no more bottles';
    }
    if (i == 1) {
      return '1 bottle';
    }
    return '$i bottles';
  }

  List<String> recite(int bottles, int start) {
    List<String> verses = [];
    for (int i = 0; i < start; i++) {
      if (i > 0) {
        verses.add('');
      }
      if (bottles == 0) {
        verses.add(
            'No more bottles of beer on the wall, no more bottles of beer.');
        verses.add(
            'Go to the store and buy some more, 99 bottles of beer on the wall.');
      } else {
        verses.add(
            '${aux(bottles)} of beer on the wall, ${aux(bottles)} of beer.');
        bottles--;
        verses.add(
            'Take ${bottles == 0 ? "it" : "one"} down and pass it around, ${aux(bottles)} of beer on the wall.');
      }
    }

    return verses;
  }
}
