package tree

import (
	"cmp"
	"errors"
	"slices"
)

type Record struct {
	ID     int
	Parent int
}

type Node struct {
	ID       int
	Children []*Node
}

func Build(records []Record) (*Node, error) {
	if len(records) == 0 {
		return nil, nil
	}
	nodes := make([]*Node, len(records))
	mp := map[int]int{}
	for _, record := range records {
		if record.ID == 0 {
			if record.Parent != 0 {
				return nil, errors.New("invalid")
			}
		} else if record.ID >= len(nodes) {
			return nil, errors.New("invalid")
		} else if record.ID <= record.Parent {
			return nil, errors.New("invalid")
		}

		node := &Node{
			ID:       record.ID,
			Children: []*Node{},
		}
		nodes[record.ID] = node
		mp[record.ID] = record.Parent
	}
	for id, parent := range mp {
		if id == 0 {
			continue
		}
		nodes[parent].Children = append(nodes[parent].Children, nodes[id])
	}

	for _, node := range nodes {
		if node == nil {
			return nil, errors.New("invalid")
		}
		slices.SortFunc(node.Children, func(a *Node, b *Node) int {
			return cmp.Compare(a.ID, b.ID)
		})
	}

	if nodes[0] == nil {
		return nil, errors.New("invalid")
	}

	return nodes[0], nil
}
