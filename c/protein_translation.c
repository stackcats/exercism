#include "protein_translation.h"

#include <string.h>

proteins_t proteins(const char *const rna) {
  proteins_t ans = {
      .valid = true,
      .count = 0,
  };
  for (size_t i = 0; i < strlen(rna); i += 3) {
    if (!strncmp("AUG", rna + i, 3)) {
      ans.proteins[ans.count++] = Methionine;
    } else if (!strncmp("UUU", rna + i, 3)) {
      ans.proteins[ans.count++] = Phenylalanine;
    } else if (!strncmp("UUC", rna + i, 3)) {
      ans.proteins[ans.count++] = Phenylalanine;
    } else if (!strncmp("UUA", rna + i, 3)) {
      ans.proteins[ans.count++] = Leucine;
    } else if (!strncmp("UUG", rna + i, 3)) {
      ans.proteins[ans.count++] = Leucine;
    } else if (!strncmp("UCU", rna + i, 3)) {
      ans.proteins[ans.count++] = Serine;
    } else if (!strncmp("UCC", rna + i, 3)) {
      ans.proteins[ans.count++] = Serine;
    } else if (!strncmp("UCA", rna + i, 3)) {
      ans.proteins[ans.count++] = Serine;
    } else if (!strncmp("UCG", rna + i, 3)) {
      ans.proteins[ans.count++] = Serine;
    } else if (!strncmp("UAU", rna + i, 3)) {
      ans.proteins[ans.count++] = Tyrosine;
    } else if (!strncmp("UAC", rna + i, 3)) {
      ans.proteins[ans.count++] = Tyrosine;
    } else if (!strncmp("UGU", rna + i, 3)) {
      ans.proteins[ans.count++] = Cysteine;
    } else if (!strncmp("UGC", rna + i, 3)) {
      ans.proteins[ans.count++] = Cysteine;
    } else if (!strncmp("UGG", rna + i, 3)) {
      ans.proteins[ans.count++] = Tryptophan;
    } else if (!strncmp("UAA", rna + i, 3)) {
      return ans;
    } else if (!strncmp("UAG", rna + i, 3)) {
      return ans;
    } else if (!strncmp("UGA", rna + i, 3)) {
      return ans;
    } else {
      ans.valid = false;
      return ans;
    }
  }
  return ans;
}
