const houseCount = 5;
const propertyCount = 5;

const red = 1;
const green = 2;
const ivory = 3;
const yellow = 4;
const blue = 5;

const milk = 1;
const coffee = 2;
const tea = 3;
const juice = 4;
const water = 5;

const dog = 1;
const snails = 2;
const fox = 3;
const horse = 4;
const zebra = 5;

const chesterfields = 1;
const kools = 2;
const luckyStrike = 3;
const parliaments = 4;
const oldGold = 5;

const englishman = 1;
const spaniard = 2;
const ukrainian = 3;
const norwegian = 4;
const japanese = 5;

const color = 0;
const pet = 1;
const beverage = 2;
const cigaret = 3;
const nationality = 4;

class ZebraPuzzle {
  String drinksWater = "";
  String ownsZebra = "";
  List<List<int>> s = [];

  ZebraPuzzle() {
    for (int i = 0; i < houseCount; i++) {
      s.add(List.generate(5, (_) => 0));
    }
  }

  bool nextTo(int house, int property, int value) {
    return (house > 0 &&
            (s[house - 1][property] == 0 || s[house - 1][property] == value)) ||
        (house < houseCount - 1 &&
            (s[house + 1][property] == 0 || s[house + 1][property] == value));
  }

  bool check() {
    for (int i = 0; i < houseCount; i++) {
      // The Englishman lives in the red house.
      if (s[i][nationality] == englishman &&
          s[i][color] != 0 &&
          s[i][color] != red) {
        return false;
      }

      // The Spaniard owns the dog.
      if (s[i][nationality] == spaniard && s[i][pet] != 0 && s[i][pet] != dog) {
        return false;
      }

      // Coffee is drunk in the green house.
      if (s[i][beverage] == coffee &&
          s[i][color] != 0 &&
          s[i][color] != green) {
        return false;
      }

      // The Ukrainian drinks tea.
      if (s[i][nationality] == ukrainian &&
          s[i][beverage] != 0 &&
          s[i][beverage] != tea) {
        return false;
      }

      // The green house is immediately to the right of the ivory house.
      if ((i == 0 && s[i][color] == green) ||
          (i > 0 &&
              s[i][color] == green &&
              s[i - 1][color] != 0 &&
              s[i - 1][color] != ivory)) {
        return false;
      }

      // The Old Gold smoker owns snails.
      if (s[i][cigaret] == oldGold && s[i][pet] != 0 && s[i][pet] != snails) {
        return false;
      }

      // Kools are smoked in the yellow house.
      if (s[i][cigaret] == kools && s[i][color] != 0 && s[i][color] != yellow) {
        return false;
      }

      // Milk is drunk in the middle house.
      if (s[i][beverage] == milk && i != houseCount ~/ 2) {
        return false;
      }

      // The Norwegian lives in the first house.
      if (s[i][nationality] == norwegian && i != 0) {
        return false;
      }

      // The man who smokes Chesterfields lives in the house next to the man with the fox.
      if (s[i][cigaret] == chesterfields && !nextTo(i, pet, fox)) {
        return false;
      }

      // Kools are smoked in the house next to the house where the horse is kept.
      if (s[i][cigaret] == kools && !nextTo(i, pet, horse)) {
        return false;
      }

      // The Lucky Strike smoker drinks orange juice.
      if (s[i][cigaret] == luckyStrike &&
          s[i][beverage] != 0 &&
          s[i][beverage] != juice) {
        return false;
      }

      // The Japanese smokes Parliaments.
      if (s[i][nationality] == japanese &&
          s[i][cigaret] != 0 &&
          s[i][cigaret] != parliaments) {
        return false;
      }

      // The Norwegian lives next to the blue house.
      if (s[i][nationality] == norwegian && !nextTo(i, color, blue)) {
        return false;
      }

      for (int j = i + 1; j < houseCount; j++) {
        for (int k = 0; k < propertyCount; k++) {
          if (s[i][k] != 0 && s[j][k] != 0 && s[i][k] == s[j][k]) {
            return false;
          }
        }
      }
    }

    return true;
  }

  bool findSolution(int house, int property) {
    final newHouse = (house + 1) % houseCount;
    final newProperty = property + (newHouse == 0 ? 1 : 0);
    final tmp = s[house][property];
    for (int v = 1; v <= 5; v++) {
      s[house][property] = v;
      if (check()) {
        if (newProperty >= propertyCount ||
            findSolution(newHouse, newProperty)) {
          return true;
        }
      }
    }
    s[house][property] = tmp;
    return false;
  }

  void solve() {
    findSolution(0, 0);

    final List<String> nationalities = [
      "Englishman",
      "Spaniard",
      "Ukrainian",
      "Norwegian",
      "Japanese",
    ];

    for (final h in s) {
      if (h[beverage] == water) {
        drinksWater = nationalities[h[nationality] - 1];
      }
      if (h[pet] == zebra) {
        ownsZebra = nationalities[h[nationality] - 1];
      }
    }
  }
}
