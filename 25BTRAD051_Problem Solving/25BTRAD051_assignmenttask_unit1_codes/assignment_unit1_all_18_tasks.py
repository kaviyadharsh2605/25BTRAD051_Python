"""
ASSIGNMENT - UNIT 1: Python Programming
Programs transcribed from the supplied 7-page PDF (Tasks 1-18).

Run this file and enter a task number from 1 to 18.
Tasks 2, 3 and 4 had their question/output shown but no answer code
in the PDF, so their straightforward implementations are supplied
from the stated questions.
"""

def task_1():
    print("Harissh ")
    print("CSE-Artificial Intelligence and Data Engineering")
    print("Jain University")

def task_2():
    for i in range(3):
        print("*******")

def task_3():
    print("Python is Easy")

def task_4():
    for i in range(1, 6):
        print("".join(str(j) for j in range(1, i + 1)))

def task_5():
    print("Computer\\nScience\\nEngineering")

def task_6():
    print("Name\\tAge\\tCity")

def task_7():
    # This program prints a welcome message
    print("Welcome to Python")

def task_8():
    """
    This is a multi-line comment
    """
    print("Python Program")

def task_9():
    # Comment 1
    # Comment 2
    # Comment 3
    print("First")
    print("Second")
    print("Third")

def task_10():
    name = "Harissh"
    print(name)

def task_11():
    a = 10
    b = 20
    c = 30
    print(a)
    print(b)
    print(c)

def task_12():
    num = "100"
    num_int = int(num)
    print(num_int)
    print(type(num_int))

def task_13():
    num = 25
    num_float = float(num)
    print(num_float)
    print(type(num_float))

def task_14():
    age = int(input("Enter your age: "))
    print("Age:", age)

def task_15():
    num1 = int(input("Enter first number: "))
    num2 = int(input("Enter second number: "))
    print("Sum =", num1 + num2)

def task_16():
    name = input("Enter name: ")
    age = int(input("Enter age: "))
    cgpa = float(input("Enter CGPA: "))
    print(f"My name is {name}. I am {age} years old and my CGPA is {cgpa}.")

def task_17():
    celsius = float(input("Enter temperature in Celsius: "))
    fahrenheit = (celsius * 9 / 5) + 32
    print(f"Temperature in Fahrenheit: {fahrenheit:.2f}")

def task_18():
    num = int(input("Enter number: "))
    if num % 2 == 0:
        print(f"{num} is Even")
    else:
        print(f"{num} is Odd")


TASKS = {
    1: task_1,
    2: task_2,
    3: task_3,
    4: task_4,
    5: task_5,
    6: task_6,
    7: task_7,
    8: task_8,
    9: task_9,
    10: task_10,
    11: task_11,
    12: task_12,
    13: task_13,
    14: task_14,
    15: task_15,
    16: task_16,
    17: task_17,
    18: task_18,
}

if __name__ == "__main__":
    print("Python Assignment - Unit 1")
    print("Available tasks: 1 to 18")
    try:
        choice = int(input("Enter task number to run: "))
        if choice in TASKS:
            print(f"\\n--- Task {choice} ---")
            TASKS[choice]()
        else:
            print("Please enter a number from 1 to 18.")
    except ValueError:
        print("Invalid input. Please enter a whole number.")
