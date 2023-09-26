bool isVowel(String s) {
  return RegExp(r'[aeiou]').hasMatch(s);
}

String aux(String s) {
  if (isVowel(s[0])) {
    return s;
  }

  if (s.substring(0, 2) == 'xr' || s.substring(0, 2) == 'yt') {
    return s;
  }

  int i = s.indexOf('qu');
  if (i != -1) {
    return s.substring(i + 2) + s.substring(0, i + 2);
  }

  i = 0;
  while (!isVowel(s[i])) {
    if (i > 0 && s[i] == 'y') {
      break;
    }
    i++;
  }
  return s.substring(i) + s.substring(0, i);
}

String translate(String s) {
  return s.split(' ').map((e) => aux(e) + 'ay').join(' ');
}
