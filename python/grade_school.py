from functools import cmp_to_key


class School:

    def __init__(self):
        self._set = set()
        self._arr = []
        self._added = []

    def add_student(self, name: str, grade: int):
        if name in self._set:
            self._added.append(False)
        else:
            self._set.add(name)
            self._arr.append((name, grade))

            def cmp(a, b):
                (n1, g1) = a
                (n2, g2) = b
                if g1 == g2:
                    if n1 < n2:
                        return -1
                    if n1 > n2:
                        return 1
                    return 0
                return g1 - g2

            self._arr.sort(key=cmp_to_key(cmp))
            self._added.append(True)

    def roster(self) -> list[str]:
        return [name for (name, _) in self._arr]

    def grade(self, grade_number: int) -> list[str]:
        return [name for (name, grade) in self._arr if grade == grade_number]

    def added(self) -> list[bool]:
        return self._added
