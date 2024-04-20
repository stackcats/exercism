import 'dart:math';

class DndCharacter {
  late int strength;
  late int constitution;
  late int dexterity;
  late int intelligence;
  late int wisdom;
  late int charisma;
  late int hitpoints;

  static int modifier(int score) {
    return ((score - 10) / 2).floor();
  }

  static int ability() {
    Random rand = Random();
    int sum = 0;
    int mi = 10;
    for (int i = 0; i < 4; i++) {
      final r = rand.nextInt(6) + 1;
      sum += r;
      mi = min(mi, r);
    }
    return sum - mi;
  }

  DndCharacter.create() {
    strength = ability();
    constitution = ability();
    dexterity = ability();
    intelligence = ability();
    wisdom = ability();
    charisma = ability();
    hitpoints = 10 + modifier(constitution);
  }
}
