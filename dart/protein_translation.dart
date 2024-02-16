class ProteinTranslation {
  List<String> translate(String codons) {
    Map<String, String> mp = {
      "AUG": "Methionine",
      "UUU": "Phenylalanine",
      "UUC": "Phenylalanine",
      "UUA": "Leucine",
      "UUG": "Leucine",
      "UCU": "Serine",
      "UCC": "Serine",
      "UCA": "Serine",
      "UCG": "Serine",
      "UAU": "Tyrosine",
      "UAC": "Tyrosine",
      "UGU": "Cysteine",
      "UGC": "Cysteine",
      "UGG": "Tryptophan",
      "UAA": "STOP",
      "UAG": "STOP",
      "UGA": "STOP",
    };
    List<String> arr = [];
    for (int i = 0; i < codons.length; i += 3) {
      String codon = codons.substring(i, i + 3);
      if (mp[codon] == null) {
        throw ArgumentError();
      }
      if (mp[codon] == "STOP") {
        return arr;
      }
      arr.add(mp[codon]!);
    }
    return arr;
  }
}
