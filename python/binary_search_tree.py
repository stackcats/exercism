class TreeNode:

    def __init__(self, data, left=None, right=None):
        self.data = data
        self.left = left
        self.right = right

    def __str__(self):
        return f'TreeNode(data={self.data}, left={self.left}, right={self.right})'


class BinarySearchTree:

    def __init__(self, tree_data):
        self._data = None
        for v in tree_data:
            self._data = self._insert(self._data, v)

    def _insert(self, curr, val):
        print(curr, val)
        if curr is None:
            curr = TreeNode(val)
        elif curr.data < val:
            curr.right = self._insert(curr.right, val)
        else:
            curr.left = self._insert(curr.left, val)
        return curr

    def data(self):
        return self._data

    def sorted_data(self):
        res = []
        st = []
        curr = self._data
        while True:
            if curr != None:
                st.append(curr)
                curr = curr.left
            else:
                if len(st) == 0:
                    break
                curr = st.pop()
                res.append(curr.data)
                curr = curr.right

        return res
