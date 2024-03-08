package binarysearchtree

type BinarySearchTree struct {
	left  *BinarySearchTree
	data  int
	right *BinarySearchTree
}

// NewBst creates and returns a new BinarySearchTree.
func NewBst(i int) *BinarySearchTree {
	return &BinarySearchTree{
		data: i,
	}
}

func insert(bst *BinarySearchTree, i int) *BinarySearchTree {
	if bst == nil {
		return NewBst(i)
	}

	if bst.data < i {
		bst.right = insert(bst.right, i)
	} else {
		bst.left = insert(bst.left, i)
	}
	return bst
}

// Insert inserts an int into the BinarySearchTree.
// Inserts happen based on the rules of a binary search tree
func (bst *BinarySearchTree) Insert(i int) {
	bst = insert(bst, i)
}

// SortedData returns the ordered contents of BinarySearchTree as an []int.
// The values are in increasing order starting with the lowest int value.
// A BinarySearchTree that has the numbers [1,3,7,5] added will return the
// []int [1,3,5,7].
func (bst *BinarySearchTree) SortedData() []int {
	curr := bst
	st := []*BinarySearchTree{}
	arr := []int{}
	for curr != nil || len(st) > 0 {
		for curr != nil {
			st = append(st, curr)
			curr = curr.left
		}

		curr = st[len(st)-1]
		arr = append(arr, curr.data)
		st = st[:len(st)-1]
		curr = curr.right
	}
	return arr
}
