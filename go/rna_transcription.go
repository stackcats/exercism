package strand

func ToRNA(dna string) string {
	mp := map[rune]string{
		'G': "C",
		'C': "G",
		'T': "A",
		'A': "U",
	}
	rna := ""
	for _, c := range dna {
		rna += mp[c]
	}
	return rna
}
