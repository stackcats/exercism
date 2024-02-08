import json
from collections import defaultdict


class User:
    def __init__(self, name, owes={}, owed_by={}, balance=0):
        self.name = name
        self.owes = defaultdict(int, owes)
        self.owed_by = defaultdict(int, owed_by)
        self.balance = balance

    @staticmethod
    def from_dict(dt):
        return User(
            name=dt["name"],
            owes=dt["owes"],
            owed_by=dt["owed_by"],
            balance=dt["balance"],
        )

    def transfer(self, other, amount):
        if other.name in self.owes:
            mi = min(amount, self.owes[other.name])
            amount -= mi
            self.owes[other.name] -= mi
            other.owed_by[self.name] -= mi
            if self.owes[other.name] == 0:
                del self.owes[other.name]
                del other.owed_by[self.name]
            self.balance += mi
            other.balance -= mi

        if amount > 0:
            self.owed_by[other.name] += amount
            other.owes[self.name] += amount
            self.balance += amount
            other.balance -= amount


class RestAPI:
    def __init__(self, database={}):
        users = database.get("users", [])
        self._db = {}
        for u in users:
            user = User.from_dict(u)
            self._db[user.name] = user

    def get(self, url, payload="{}"):
        query = json.loads(payload)
        if url == "/users":
            users = list(self._db.values())
            if query != {}:
                users = [u.__dict__ for u in users if u.name in query["users"]]

            res = {"users": users}
            return json.dumps(res)

    def post(self, url, payload="{}"):
        body = json.loads(payload)

        if url == "/add":
            user = User(body["user"])
            self._db[user.name] = user
            return json.dumps(user.__dict__)

        if url == "/iou":
            lender = self._db[body["lender"]]
            borrower = self._db[body["borrower"]]
            amount = body["amount"]

            lender.transfer(borrower, amount)

            users = [lender.__dict__, borrower.__dict__]
            users = sorted(users, key=lambda u: u["name"])

            res = {"users": users}

            return json.dumps(res)
