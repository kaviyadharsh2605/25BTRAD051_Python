import random

random.seed(7)
rolls = [random.randint(1, 6) for _ in range(10)]
print("Ten dice rolls:", rolls)
print("Frequency:")
for face in range(1, 7):
    print(f"{face}: {rolls.count(face)}")
