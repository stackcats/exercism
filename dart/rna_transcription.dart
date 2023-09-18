class RnaTranscription {
  String toRna(String dna) {
    Map<String, String> mp = {'C': 'G', 'G': 'C', 'T': 'A', 'A': 'U'};
    String rna = '';
    for (int i = 0; i < dna.length; i++) {
      rna += mp[dna[i]] ?? '';
    }
    return rna;
  }
}
