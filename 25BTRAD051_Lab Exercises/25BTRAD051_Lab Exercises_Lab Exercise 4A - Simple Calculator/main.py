def calculator(num1, num2, choice):
    if choice == '+':
        return num1 + num2
    elif choice == '-':
        return num1 - num2
    elif choice == '*':
        return num1 * num2
    elif choice == '/':
        return num1 / num2 if num2 != 0 else "Error: Division by zero"
    else:
        return "Invalid operator"

print("Name: Harissh M V")
print("USN: 25BTRAD051")
print("-" * 40)
print("Simple Calculator")
print("-" * 40)
num1 = 5
num2 = 10
print(f"Enter first number: {num1}")
print(f"Enter second number: {num2}")
for op in ['+', '-', '*', '/']:
    print(f"Enter operator (+, -, *, /): {op}")
    result = calculator(num1, num2, op)
    print(f"Result: {num1} {op} {num2} = {result}")
    print("-" * 40)
