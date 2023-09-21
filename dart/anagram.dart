extension StringSorting on String {
  String sort() {
    List<String> arr = this.split('');
    arr.sort();
    return arr.join('');
  }
}

class Anagram {
  List<String> findAnagrams(String target, List<String> candidates) {
    List<String> ans = [];
    target = target.toLowerCase();
    String sorted = target.sort();
    for (int i = 0; i < candidates.length; i++) {
      String tmp = candidates[i].toLowerCase();
      if (tmp == target) {
        continue;
      }
      if (sorted == tmp.sort()) {
        ans.add(candidates[i]);
      }
    }
    return ans;
  }
}
