class CustomSet:
    def __init__(self, elements=[]):
        self.elements = list(set(elements))

    def isempty(self):
        return self.elements == []

    def __contains__(self, element):
        return element in self.elements

    def issubset(self, other):
        for each in self.elements:
            if each not in other:
                return False
        return True

    def isdisjoint(self, other):
        for each in self.elements:
            if each in other:
                return False
        return True

    def __eq__(self, other):
        if len(self.elements) != len(other.elements):
            return False

        return self.issubset(other)

    def add(self, element):
        if element not in self.elements:
            self.elements.append(element)

    def intersection(self, other):
        cs = CustomSet()
        for each in self.elements:
            if each in other:
                cs.add(each)
        return cs

    def __sub__(self, other):
        cs = CustomSet()
        for each in self.elements:
            if each not in other:
                cs.add(each)
        return cs

    def __add__(self, other):
        for each in self.elements:
            if each not in other:
                other.add(each)
        return other
