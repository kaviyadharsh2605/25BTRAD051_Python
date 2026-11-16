class BankAccount:
    def __init__(self, owner, balance=0):
        self.owner = owner
        self._balance = balance

    def deposit(self, amount):
        if amount <= 0:
            return False
        self._balance += amount
        return True

    def withdraw(self, amount):
        if amount <= 0 or amount > self._balance:
            return False
        self._balance -= amount
        return True

    def balance(self):
        return self._balance

account = BankAccount("Harissh", 1000)
print("Opening balance:", account.balance())
print("Deposit Rs.500:", account.deposit(500))
print("Withdraw Rs.300:", account.withdraw(300))
print("Withdraw Rs.2000:", account.withdraw(2000))
print("Final balance:", account.balance())
