local BankAccount = {}

function BankAccount:new()
    local t = {}
    setmetatable(t, self)
    self.__index = self
    self._balance = 0
    return t
end

function BankAccount:balance()
    return self._balance
end

function BankAccount:deposit(amount)
    if self._isclose then
        return error("account already closed")
    end

    if amount <= 0 then
        return error("amount must > 0")
    end

    self._balance = self._balance + amount
end

function BankAccount:withdraw(amount)
    if self._isclose then
        return error("account already closed")
    end

    if amount <= 0 then
        return error("amount must > 0")
    end

    self._balance = self._balance - amount

    if self._balance < 0 then
        return error("balance must >= 0")
    end
end

function BankAccount:close()
    self._isclose = true
end

return BankAccount
