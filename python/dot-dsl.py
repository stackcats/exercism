NODE, EDGE, ATTR = range(3)


class Node:
    def __init__(self, name, attrs):
        self.name = name
        self.attrs = attrs

    def __eq__(self, other):
        return self.name == other.name and self.attrs == other.attrs


class Edge:
    def __init__(self, src, dst, attrs):
        self.src = src
        self.dst = dst
        self.attrs = attrs

    def __eq__(self, other):
        return (self.src == other.src and
                self.dst == other.dst and
                self.attrs == other.attrs)


class Graph:
    def __init__(self, data=[]):
        if not isinstance(data, list):
            raise TypeError("Graph data malformed")
        self.nodes = []
        self.edges = []
        self.attrs = {}
        for each in data or []:
            if len(each) < 2:
                raise TypeError("Graph item incomplete")
            if each[0] == NODE:
                if len(each) != 3:
                    raise ValueError("Node is malformed")
                _, name, attrs = each
                self.nodes.append(Node(name, attrs))
            elif each[0] == EDGE:
                if len(each) != 4:
                    raise ValueError("Edge is malformed")
                _, a, b, attrs = each
                self.edges.append(Edge(a, b, attrs))
            elif each[0] == ATTR:
                if len(each) != 3:
                    raise ValueError("Attribute is malformed")
                _, k, v = each
                self.attrs[k] = v
            else:
                raise ValueError("Unknown item")

