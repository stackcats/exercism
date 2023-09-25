class ResistorColorDuo {
  List<String> get colors {
    return [
      'black',
      'brown',
      'red',
      'orange',
      'yellow',
      'green',
      'blue',
      'violet',
      'grey',
      'white'
    ];
  }

  int colorCode(String color) {
    return colors.indexOf(color);
  }

  int value(List<String> colors) {
    return colors.sublist(0, 2).fold(0, (acc, c) => acc * 10 + colorCode(c));
  }
}
