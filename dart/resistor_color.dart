class ResistorColor {
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
}
