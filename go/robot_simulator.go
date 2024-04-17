package robot

import (
	"strings"
)

// See defs.go for other definitions

// Step 1
// Define N, E, S, W here.
const (
	N = iota
	E
	S
	W
	End
)

func Right() {
	Step1Robot.Dir = (Step1Robot.Dir + 1) % End
}

func Left() {
	Step1Robot.Dir = (Step1Robot.Dir - 1 + End) % End
}

func Advance() {
	switch Step1Robot.Dir {
	case N:
		Step1Robot.Y++
	case E:
		Step1Robot.X++
	case S:
		Step1Robot.Y--
	case W:
		Step1Robot.X--
	}
}

func (d Dir) String() string {
	return ""
}

// Step 2
// Define Action type here.
type Action Command

func StartRobot(command chan Command, action chan Action) {
	for c := range command {
		action <- Action(c)
	}
	close(action)
}

func Room(extent Rect, robot Step2Robot, action chan Action, report chan Step2Robot) {
	for act := range action {
		switch act {
		case 'R':
			robot.Dir = (robot.Dir + 1) % End
		case 'L':
			robot.Dir = (robot.Dir - 1 + End) % End
		case 'A':
			pos := advance2(robot.Pos, robot.Dir)
			if inRoom(extent, pos) {
				robot.Pos = pos
			}
		}
	}

	report <- robot
}

func inRoom(extent Rect, pos Pos) bool {
	return pos.Easting >= extent.Min.Easting && pos.Easting <= extent.Max.Easting &&
		pos.Northing >= extent.Min.Northing && pos.Northing <= extent.Max.Northing
}
func advance2(p Pos, dir Dir) Pos {
	q := p
	switch dir {
	case N:
		q.Northing++
	case E:
		q.Easting++
	case S:
		q.Northing--
	case W:
		q.Easting--
	}
	return q
}

// Step 3
// Define Action3 type here.
type Action3 struct {
	cmd  Command
	name string
	done bool
}

func StartRobot3(name, script string, action chan Action3, log chan string) {
	for _, c := range script {

		if !strings.Contains("RLA", string(c)) {
			log <- "An undefined command in a script"
			break
		}

		action <- Action3{
			cmd:  Command(c),
			name: name,
		}
	}
	action <- Action3{
		done: true,
	}
}

func Room3(extent Rect, robots []Step3Robot, action chan Action3, rep chan []Step3Robot, log chan string) {
	roboMap := map[string]int{}
	locations := map[Pos]bool{}

	for i, robot := range robots {
		if robot.Name == "" {
			log <- "A robot without a name"
			continue
		}

		if _, ok := roboMap[robot.Name]; ok {
			log <- "Duplicate robot names"
			continue
		}

		if locations[robot.Pos] {
			log <- "Robots placed at the same place"
			continue
		}

		if !inRoom(extent, robot.Pos) {
			log <- "A robot placed outside of the room"
			continue
		}

		locations[robot.Pos] = true
		roboMap[robot.Name] = i
	}

	ct := len(robots)

	for act := range action {
		if act.done {
			ct--
			if ct <= 0 {
				close(action)
				break
			}
		}

		ndx := roboMap[act.name]
		robot := &robots[ndx]

		switch act.cmd {
		case 'R':
			robot.Dir = (robot.Dir + 1) % End
		case 'L':
			robot.Dir = (robot.Dir - 1 + End) % End
		case 'A':
			pos := advance2(robot.Pos, robot.Dir)
			if !inRoom(extent, pos) {
				log <- "A robot attempting to advance into a wall"
			} else if locations[pos] {
				log <- "A robot attempting to advance into another robot"
			} else {
				delete(locations, robot.Pos)
				robot.Pos = pos
				locations[pos] = true
			}

		}
	}

	rep <- robots
}
