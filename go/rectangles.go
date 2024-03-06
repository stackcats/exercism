package rectangles

import (
    "cmp"
    "slices"
)

type Point struct {
    x int
    y int
}

func Count(diagram []string) int {
	arr := []Point{}
    for i, line := range diagram {
        for j, c := range line {
            if c == '+' {
                arr = append(arr, Point{x: i, y: j})
            }
        }
    }

    slices.SortFunc(arr, func(a, b Point) int {
        if a.x == b.x {
            return cmp.Compare(a.y, b.y)
        }
    	return cmp.Compare(a.x, b.x)
    })

    ct := 0
    for i := 0; i < len(arr); i++ {
        for j := i + 1; j < len(arr); j++ {
            for k := j + 1; k < len(arr); k++ {
                for m := k + 1; m < len(arr); m++ {
                    points := []Point{
                        arr[i], 
                        arr[j], 
                        arr[k], 
                        arr[m],
                    }
                    if isRect(diagram, points) {
                        ct++
                    }
                }
            }
        }
    }

    return ct
}

func isRect(diagram []string, points []Point) bool {
    if points[0].x != points[1].x || points[0].y != points[2].y || points[1].y != points[3].y || points[2].x != points[3].x {
        return false
    }

    for y := points[0].y; y < points[1].y; y++ {
        if diagram[points[0].x][y] != '-' && diagram[points[0].x][y] != '+' {
            return false
        }
    	if diagram[points[2].x][y] != '-' && diagram[points[2].x][y] != '+' {
            return false
        }
    }

    for x := points[0].x; x < points[2].x; x++ {
        if diagram[x][points[0].y] != '|' && diagram[x][points[0].y] != '+' {
            return false
        }
    	if diagram[x][points[1].y] != '|' && diagram[x][points[1].y] != '+' {
            return false
        }
    }

    return true
}

