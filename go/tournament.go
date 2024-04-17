package tournament

import (
    "bufio"
    "cmp"
    "errors"
    "fmt"
    "io"
    "slices"
    "strings"
)

type Match struct {
    win int
    draw int
    loss int
}

func Tally(reader io.Reader, writer io.Writer) error {
    matches := map[string]*Match{}
	scanner := bufio.NewScanner(reader)
    for scanner.Scan() {
        line := scanner.Text()
        line = strings.Trim(line, " ")
        if len(line) == 0 || line[0] == '#' {
            continue
        }
    
    	arr := strings.Split(line, ";")
        if len(arr) != 3 {
            return errors.New("invalid")
        }
    	
        t1 := arr[0]
        t2 := arr[1]

        if matches[t1] == nil {
            matches[t1] = &Match{}
        }

        if matches[t2] == nil {
            matches[t2] = &Match{}
        }
    
        switch arr[2] {
            case "win":
        		matches[t1].win++
            	matches[t2].loss++
            case "draw":
        		matches[t1].draw++
            	matches[t2].draw++
            case "loss":
            	matches[t1].loss++
            	matches[t2].win++
            default:
        		return errors.New("invalid")
        }
    }

    teams := []string{}
    for k := range matches {
        teams = append(teams, k)
    }

    slices.SortFunc(teams, func(a, b string) int {
        sa := score(matches[a])
        sb := score(matches[b])
        if sa == sb {
            return cmp.Compare(a, b)
        }
    	return cmp.Compare(sb, sa)
    })

    fmt.Fprintf(writer, "Team                           | MP |  W |  D |  L |  P\n")

    for _, team := range teams {
        match := matches[team]
        fmt.Fprintf(writer, "%-31s|%3d |%3d |%3d |%3d |%3d\n", team, match.win + match.draw + match.loss, match.win, match.draw, match.loss, score(match))
    }

    return nil
}


func score(match *Match) int {
    return 3 * match.win + match.draw
}
