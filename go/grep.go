package grep

import (
	"fmt"
	"os"
	"regexp"
	"strings"
)

func Search(pattern string, flags, files []string) []string {
	showLineNum := false
	onlyFilename := false
	caseInsensitive := false
	invert := false
	matchEntireLine := false

	for _, flag := range flags {
		switch flag {
		case "-n":
			showLineNum = true
		case "-l":
			onlyFilename = true
		case "-i":
			caseInsensitive = true
		case "-v":
			invert = true
		case "-x":
			matchEntireLine = true
		}
	}

	if caseInsensitive {
		pattern = "(?i)" + pattern
	}

	if matchEntireLine {
		pattern = "^" + pattern + "$"
	}

	re, err := regexp.Compile(pattern)
	if err != nil {
		return []string{}
	}

	res := []string{}
	for _, file := range files {
		content, _ := os.ReadFile(file)
		lines := strings.Split(string(content), "\n")
		for i, line := range lines {
			line = strings.Trim(line, " ")
			if line == "" {
				continue
			}

			match := re.MatchString(line)
			if match && !invert || !match && invert {
				if onlyFilename {
					res = append(res, file)
					break
				}
				if showLineNum {
					line = fmt.Sprintf("%d:%s", i+1, line)
				}

				if len(files) > 1 {
					line = file + ":" + line
				}

				res = append(res, line)
			}
		}
	}
	return res
}
