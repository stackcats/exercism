class BankAccount:
    def __init__(self):
        self._balance = 0
        self._isopen = False

    def get_balance(self):
        if not self._isopen:
            raise ValueError("account not open")
        return self._balance

    def open(self):
        if self._isopen:
            raise ValueError("account already open")
        self._isopen = True

    def deposit(self, amount):
        if not self._isopen:
            raise ValueError("account not open")
        if amount <= 0:
            raise ValueError("amount must be greater than 0")
        self._balance += amount

    def withdraw(self, amount):
        if not self._isopen:
            raise ValueError("account not open")
        if amount <= 0:
            raise ValueError("amount must be greater than 0")
        if amount > self._balance:
            raise ValueError("amount must be less than balance")
        self._balance -= amount

    def close(self):
        if not self._isopen:
            raise ValueError("account not open")
        self._isopen = False
        self._balance = 0
