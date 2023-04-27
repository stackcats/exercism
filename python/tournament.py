class Team:

    def __init__(self, name):
        self.name = name
        self.mp = 0
        self.w = 0
        self.d = 0
        self.l = 0

    def points(self):
        return self.w * 3 + self.d

    def win(self):
        self.mp += 1
        self.w += 1

    def loss(self):
        self.mp += 1
        self.l += 1

    def draw(self):
        self.mp += 1
        self.d += 1

    def __str__(self):
        return f'{self.name: <31}|{self.mp: >3} |{self.w: >3} |{self.d: >3} |{self.l: >3} |{self.points(): >3}'


def tally(rows):
    teams = {}
    for row in rows:
        [team_a, team_b, result] = row.split(';')
        if team_a not in teams:
            teams[team_a] = Team(team_a)
        if team_b not in teams:
            teams[team_b] = Team(team_b)

        if result == 'win':
            teams[team_a].win()
            teams[team_b].loss()
        elif result == 'draw':
            teams[team_a].draw()
            teams[team_b].draw()
        else:
            teams[team_a].loss()
            teams[team_b].win()

    table = ["Team                           | MP |  W |  D |  L |  P"]
    team_lst = sorted(teams.values(), key=lambda t: (-t.points(), t.name))
    for team in team_lst:
        table.append(f'{team}')
    return table
