class HighScores:

    def __init__(self, scores):
        self.scores = scores
        self._lst = sorted(scores, reverse=True)

    def personal_top_three(self):
        return self._lst[:3]

    def latest(self):
        return self.scores[-1]

    def personal_best(self):
        return self._lst[0]
