package protein

import "errors"

var ErrStop = errors.New("error stop")
var ErrInvalidBase = errors.New("invalid")

func FromRNA(rna string) ([]string, error) {
	arr := []string{}
	for i := 0; i < len(rna); i += 3 {
		s, err := FromCodon(rna[i : i+3])
		if err == ErrStop {
			break
		}

		if err != nil {
			return []string{}, err
		}

		arr = append(arr, s)
	}
	return arr, nil
}

func FromCodon(codon string) (string, error) {
	switch codon {
	case "AUG":
		return "Methionine", nil
	case "UUU":
		fallthrough
	case "UUC":
		return "Phenylalanine", nil
	case "UUA":
		fallthrough
	case "UUG":
		return "Leucine", nil
	case "UCU":
		fallthrough
	case "UCC":
		fallthrough
	case "UCA":
		fallthrough
	case "UCG":
		return "Serine", nil
	case "UAU":
		fallthrough
	case "UAC":
		return "Tyrosine", nil
	case "UGU":
		fallthrough
	case "UGC":
		return "Cysteine", nil
	case "UGG":
		return "Tryptophan", nil
	case "UAA":
		fallthrough
	case "UAG":
		fallthrough
	case "UGA":
		return "", ErrStop
	}
	return "", ErrInvalidBase
}
