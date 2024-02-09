class Zipper:
    @staticmethod
    def from_tree(tree):
        return Zipper(tree)

    def __init__(self, tree):
        self.tree = tree
        self.focus = tree
        self.path = []

    def value(self):
        return self.focus["value"]

    def set_value(self, value):
        self.focus["value"] = value
        return self

    def left(self):
        self.path.append(self.focus)
        self.focus = self.focus["left"]
        return self if self.focus else None

    def set_left(self, left):
        self.focus["left"] = left
        return self

    def right(self):
        self.path.append(self.focus)
        self.focus = self.focus["right"]
        return self if self.focus else None

    def set_right(self, right):
        self.focus["right"] = right
        return self

    def up(self):
        if self.path != []:
            self.focus = self.path.pop()
            return self
        return None

    def to_tree(self):
        return self.tree
