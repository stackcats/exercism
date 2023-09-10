class SpaceAge {
  Map<String, double> mp = {
    'Earth': 1,
    'Mercury': 0.2408467,
    'Venus': 0.61519726,
    'Mars': 1.8808158,
    'Jupiter': 11.862615,
    'Saturn': 29.447498,
    'Uranus': 84.016846,
    'Neptune': 164.79132,
  };

  double age({required String planet, required double seconds}) {
    double age = seconds / (mp[planet] ?? 1) / 31557600;
    return (age * 100).round() / 100;
  }
}
