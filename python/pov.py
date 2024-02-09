from json import dumps


class Tree:
    def __init__(self, label, children=None):
        self.label = label
        self.children = children if children is not None else []

    def __dict__(self):
        return {self.label: [c.__dict__() for c in sorted(self.children)]}

    def __str__(self, indent=None):
        return dumps(self.__dict__(), indent=indent)

    def __lt__(self, other):
        return self.label < other.label

    def __eq__(self, other):
        return self.__dict__() == other.__dict__()

    def to_nodes(self, nodes):
        for child in self.children:
            nodes[self.label].append(child.label)
            nodes[child.label] = [self.label]
            child.to_nodes(nodes)

    @staticmethod
    def from_nodes(nodes, curr, parent):
        t = Tree(curr)
        for each in nodes[curr]:
            if each != parent:
                t.children.append(Tree.from_nodes(nodes, each, curr))
        return t

    def from_pov(self, from_node):
        nodes = {self.label: []}
        self.to_nodes(nodes)
        if from_node not in nodes:
            raise ValueError("Tree could not be reoriented")
        return Tree.from_nodes(nodes, from_node, None)

    def find_path(self, to_node, visited):
        print(self.label)
        if self.label == to_node:
            return [to_node]
        if self.label in visited:
            return None
        visited.add(self.label)
        for child in self.children:
            path = child.find_path(to_node, visited)
            if path is None:
                continue
            path.append(self.label)
            return path
        return None

    def path_to(self, from_node, to_node):
        path = self.from_pov(from_node).find_path(to_node, set())
        if path is None:
            raise ValueError("No path found")
        return path[::-1]
