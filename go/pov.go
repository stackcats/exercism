package pov

type Tree struct {
	value    string
	children []*Tree
}

// New creates and returns a new Tree with the given root value and children.
func New(value string, children ...*Tree) *Tree {
	return &Tree{
		value:    value,
		children: children,
	}
}

// Value returns the value at the root of a tree.
func (tr *Tree) Value() string {
	return tr.value
}

// Children returns a slice containing the children of a tree.
// There is no need to sort the elements in the result slice,
// they can be in any order.
func (tr *Tree) Children() []*Tree {
	return tr.children
}

// String describes a tree in a compact S-expression format.
// This helps to make test outputs more readable.
// Feel free to adapt this method as you see fit.
func (tr *Tree) String() string {
	if tr == nil {
		return "nil"
	}
	result := tr.Value()
	if len(tr.Children()) == 0 {
		return result
	}
	for _, ch := range tr.Children() {
		result += " " + ch.String()
	}
	return "(" + result + ")"
}

// POV problem-specific functions

func (tr *Tree) tracePath(target string) []*Tree {
	if target == tr.Value() {
		return []*Tree{tr}
	}
	for _, c := range tr.Children() {
		path := c.tracePath(target)
		if path != nil {
			path = append(path, tr)
			return path
		}
	}
	return nil
}

// FromPov returns the pov from the node specified in the argument.
func (tr *Tree) FromPov(from string) *Tree {
	path := tr.tracePath(from)
	if len(path) == 0 {
		return nil
	}
	for i := 0; i < len(path)-1; i++ {
		curr := path[i]
		parent := path[i+1]
		for i, c := range parent.children {
			if c == curr {
				parent.children = append(parent.children[:i], parent.children[i+1:]...)
				break
			}
		}
		curr.children = append(curr.children, parent)
	}
	return path[0]
}

// PathTo returns the shortest path between two nodes in the tree.
func (tr *Tree) PathTo(from, to string) []string {
	arr := []string{}

	t := tr.FromPov(from)
	if t == nil {
		return arr
	}

	path := t.tracePath(to)
	if path == nil {
		return arr
	}

	for i := len(path) - 1; i >= 0; i-- {
		arr = append(arr, path[i].value)
	}
	return arr
}
