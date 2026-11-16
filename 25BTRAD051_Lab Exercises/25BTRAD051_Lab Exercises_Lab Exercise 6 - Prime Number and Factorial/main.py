def is_prime(n):
    if n < 2:
        return False
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            return False
    return True

print("Prime Number Check")
a = int(input("enter the number"))
if is_prime(a):
    print(f"{a} is a Prime Number")
else:
    print(f"{a} is not a Prime Number")

def factorial(n):
    result = 1
    for i in range(1, n + 1):
        result *= i
    return result

print("Factorial Calculation")
b = int(input("enter the number"))
print(f"Enter a number: {b}")
print(f"Factorial of {b} = {factorial(b)}")
