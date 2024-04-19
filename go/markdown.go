package markdown

import (
	"fmt"
	"regexp"
	"strings"
)

// Render translates markdown to HTML
func Render(m string) string {
	for i := 6; i > 0; i-- {
		pattern := fmt.Sprintf(`(?m)^%s (.*)$`, strings.Repeat("#", i))
		replace := fmt.Sprintf("<h%d>$1</h%d>", i, i)
		re := regexp.MustCompile(pattern)
		m = re.ReplaceAllString(m, replace)
	}

	m = regexp.MustCompile(`__(.*)__`).ReplaceAllString(m, "<strong>$1</strong>")
	m = regexp.MustCompile(`_(.*)_`).ReplaceAllString(m, "<em>$1</em>")
	m = regexp.MustCompile(`(?m)^\* (.*)$`).ReplaceAllString(m, "<li>$1</li>")
	m = regexp.MustCompile(`(?s)(<li>.*</li>)`).ReplaceAllString(m, "<ul>$1</ul>")

	s := strings.Builder{}
	r := regexp.MustCompile(`^<[hlu]`)
	for _, line := range strings.Split(m, "\n") {
		if r.MatchString(line) {
			s.WriteString(line)
		} else {
			s.WriteString("<p>" + line + "</p>")
		}
	}
	return s.String()
}
