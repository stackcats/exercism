package spiralmatrix

func SpiralMatrix(size int) [][]int {
	mat := make([][]int, size)
	for i := 0; i < size; i++ {
		mat[i] = make([]int, size)
	}

	dx := 0
	dy := 1
	x := 0
	y := 0

	for i := 1; i <= size*size; i++ {
		mat[x][y] = i
		nx := x + dx
		ny := y + dy
		if nx < 0 || nx >= size || ny < 0 || ny >= size || mat[nx][ny] > 0 {
			t := dx
			dx = dy
			dy = -t
		}
		x += dx
		y += dy
	}

	return mat
}
