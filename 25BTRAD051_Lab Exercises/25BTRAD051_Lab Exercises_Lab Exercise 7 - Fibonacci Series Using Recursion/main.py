def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)

print("Fibonacci Series using Recursion")
print("-" * 40)
terms = 10
print(f"Enter number of terms: {terms}")
print("-" * 40)
series = [fibonacci(i) for i in range(terms)]
print("Fibonacci Series:")
print(", ".join(str(x) for x in series))
print("-" * 40)
for i, val in enumerate(series):
    print(f"fibonacci({i}) = {val}")
