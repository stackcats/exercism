package chessboard

type File []bool

type Chessboard map[string]File

func CountInFile(cb Chessboard, file string) int {
	ct := 0
	for _, b := range cb[file] {
		if b {
			ct += 1
		}
	}
	return ct
}

func CountInRank(cb Chessboard, rank int) int {
	if rank < 1 || rank > 8 {
		return 0
	}

	ct := 0
	for _, file := range cb {
		if file[rank-1] {
			ct += 1
		}
	}
	return ct
}

func CountAll(cb Chessboard) int {
	ct := 0
	for _, file := range cb {
		ct += len(file)
	}
	return ct
}

func CountOccupied(cb Chessboard) int {
	ct := 0
	for _, file := range cb {
		for _, b := range file {
			if b {
				ct += 1
			}
		}
	}
	return ct
}
