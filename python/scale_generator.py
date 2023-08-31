SHARP = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
FLAT = ['C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'B']


class Scale:

    def __init__(self, tonic: str):
        self.tonic = tonic

    def chromatic(self) -> list[str]:
        pithes = SHARP
        if self.tonic in ['F', 'Bb', 'Eb', 'Ab', 'Db', 'Gb'
                          ] or self.tonic in ['d', 'g', 'c', 'f', 'bb', 'eb']:
            pithes = FLAT

        ndx = pithes.index(self.tonic.capitalize())

        return pithes[ndx:] + pithes[:ndx]

    def interval(self, intervals: str) -> list[str]:
        chromatic = self.chromatic()
        i = 0
        scales = []
        for interval in intervals:
            scales.append(chromatic[i])
            if interval == 'M':
                i += 2
            elif interval == 'm':
                i += 1
            else:
                i += 3

            i = i % len(chromatic)

        scales.append(self.tonic.capitalize())
        return scales
