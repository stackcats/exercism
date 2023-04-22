DEFAULT_STUDENTS = [
    'Alice', 'Bob', 'Charlie', 'David', 'Eve', 'Fred', 'Ginny', 'Harriet',
    'Ileana', 'Joseph', 'Kincaid', 'Larry'
]

PLANT_MAP = {'V': 'Violets', 'R': 'Radishes', 'G': 'Grass', 'C': 'Clover'}


class Garden:

    def __init__(self, diagram, students=DEFAULT_STUDENTS):
        self._students = sorted(students)
        self._garden = diagram.split('\n')

    def plants(self, name):
        ndx = self._students.index(name)
        plant_ndx = ndx * 2
        plants = [
            self._garden[0][plant_ndx], self._garden[0][plant_ndx + 1],
            self._garden[1][plant_ndx], self._garden[1][plant_ndx + 1]
        ]
        return [PLANT_MAP[plant] for plant in plants]
