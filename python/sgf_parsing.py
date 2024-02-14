class SgfTree:
    def __init__(self, properties=None, children=None):
        self.properties = properties or {}
        self.children = children or []

    def __eq__(self, other):
        if not isinstance(other, SgfTree):
            return False
        for key, value in self.properties.items():
            if key not in other.properties:
                return False
            if other.properties[key] != value:
                return False
        for key in other.properties.keys():
            if key not in self.properties:
                return False
        if len(self.children) != len(other.children):
            return False
        for child, other_child in zip(self.children, other.children):
            if child != other_child:
                return False
        return True

    def __ne__(self, other):
        return not self == other

class Parser:
    def __init__(self, s = ""):
        self.pos = 0
        self.token = s

    @property
    def curr(self):
        if self.pos >= len(self.token):
            raise ValueError("invalid tree")
        return self.token[self.pos]
        
    def parse_tree(self):
        if not self.token.startswith("("):
            raise ValueError("tree missing")
        return self.parse_node()

    def parse_node(self):
        if self.curr == "(":
            self.pos += 1
        if self.curr == ")":
            raise ValueError("tree with no nodes")

        # skip ;
        self.pos += 1
        
        properties = {}
        children = []
        
        while self.curr not in "(;)":
            properties |= self.parse_properties()

        while self.pos < len(self.token) and self.curr != ")":
            children.append(self.parse_node())
        
        self.pos += 1
        
        return SgfTree(properties, children)

    def parse_properties(self):
        key = ""
        while self.curr.isupper():
            key += self.curr
            self.pos += 1
        if self.curr.islower():
            raise ValueError("property must be in uppercase")
        if self.curr != "[":
            raise ValueError("properties without delimiter")

        values = []

        while self.curr == "[":
            self.pos += 1
            value = ""
            while self.curr != "]":
                if self.curr == "\t":
                    value += " "
                elif self.curr == "\\" and self.pos + 1 < len(self.token):
                    if self.token[self.pos + 1] == "\n":
                        ...
                    elif self.token[self.pos + 1] == "\t":
                        value += " "
                    else:
                        value += self.token[self.pos + 1]
                    self.pos += 1
                else:
                    value += self. curr
                self.pos += 1
                
            self.pos += 1
            values.append(value)
        
        return { key: values }

def parse(input_string):
    p = Parser(input_string)
    return p.parse_tree()

