from typing import Self


class Clock:

    def __init__(self, hour: int, minute: int):
        self.hour = hour
        self.minute = minute
        self._simplify()

    def __repr__(self) -> str:
        return f'Clock({self.hour}, {self.minute})'

    def __str__(self) -> str:
        return f'{self.hour:02}:{self.minute:02}'

    def __eq__(self, other: Self) -> bool:
        return self.hour == other.hour and self.minute == other.minute

    def __add__(self, minutes: int):
        return Clock(self.hour, self.minute + minutes)

    def __sub__(self, minutes: int):
        return Clock(self.hour, self.minute - minutes)

    def _simplify(self):
        self.hour += self.minute // 60
        self.minute %= 60
        self.hour %= 24
