import random

print("Number Guessing Game")
print("I have selected a number between 1 and 50.")
print("-" * 40)
secret = random.randint(1, 50)
attempts = 0
while True:
    guess = int(input("Enter your guess: "))
    attempts += 1
    if guess == secret:
        print(f"Correct! You guessed the number in {attempts} attempts.")
        break
    elif guess < secret:
        print("Too low! Try again.")
    else:
        print("Too high! Try again.")
    print("-" * 40)
