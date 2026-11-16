students = {"Asha": 92, "Bala": 76, "Charan": 58, "Diya": 34}

def grade(mark):
    if mark >= 90:
        return "A"
    if mark >= 75:
        return "B"
    if mark >= 60:
        return "C"
    if mark >= 40:
        return "D"
    return "F"

print("STUDENT RESULTS")
for name, mark in students.items():
    print(f"{name}: {mark} marks - Grade {grade(mark)}")
