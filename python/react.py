class InputCell:
    def __init__(self, initial_value):
        self._value = initial_value
        self.children = []

    @property
    def value(self):
        return self._value

    @value.setter
    def value(self, value):
        self._value = value
        for child in self.children:
            child.propagate()
        for child in self.children:
            child.update()

    def __int__(self):
        return int(self.value)

    def add_child(self, child):
        self.children.append(child)


class ComputeCell:
    def __init__(self, inputs, compute_function):
        self.inputs = inputs
        self.fn = compute_function
        self.children = []
        self.callbacks = []

        self._value = self.compute()
        self.pre_value = self._value

        for input in inputs:
            input.add_child(self)

    @property
    def value(self):
        return self._value

    def __int__(self):
        return int(self.value)

    def compute(self):
        return self.fn([int(x) for x in self.inputs])

    def add_child(self, child):
        self.children.append(child)

    def propagate(self):
        self._value = self.compute()
        for child in self.children:
            child.propagate()

    def update(self):
        if self.pre_value != self.value:
            for callback in self.callbacks:
                callback(self.value)
            self.pre_value = self.value
        for child in self.children:
            child.update()

    def add_callback(self, callback):
        self.callbacks.append(callback)

    def remove_callback(self, callback):
        try:
            self.callbacks.remove(callback)
        except:
            ...
