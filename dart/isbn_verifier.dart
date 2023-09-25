bool isValid(String isbn) {
  isbn = isbn.replaceAll('-', '');
  if (isbn.length != 10) {
    return false;
  }

  int n = 10;
  int sum = 0;
  for (int i = 0; i < isbn.length; i++) {
    if (isbn[i] == 'X') {
      sum += n * 10;
      continue;
    }

    int? d = int.tryParse(isbn[i]);
    if (d == null) {
      return false;
    }
    sum += n * d;
    n--;
  }

  return sum % 11 == 0;
}
