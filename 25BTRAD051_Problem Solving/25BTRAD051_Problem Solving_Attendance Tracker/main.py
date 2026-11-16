"""Class attendance tracker using a dictionary of student records."""
attendance = {}

def add_student(name):
    name = name.strip().title()
    if not name:
        print("Student name cannot be empty.")
    elif name in attendance:
        print(f"{name} is already in the tracker.")
    else:
        attendance[name] = {"present": 0, "total": 0}
        print(f"Added student: {name}")

def record_attendance(name, status):
    name = name.strip().title()
    status = status.strip().lower()
    if name not in attendance:
        print(f"Student not found: {name}")
    elif status not in ("present", "absent"):
        print("Status must be present or absent.")
    else:
        attendance[name]["total"] += 1
        if status == "present":
            attendance[name]["present"] += 1
        print(f"Recorded {status} for {name}.")

def percentage(record):
    if record["total"] == 0:
        return 0.0
    return record["present"] / record["total"] * 100

def display_attendance():
    print("\nATTENDANCE RECORDS")
    print(f"{'Student':<18}{'Present':>9}{'Classes':>9}{'Attendance':>13}")
    for name, record in attendance.items():
        print(f"{name:<18}{record['present']:>9}{record['total']:>9}{percentage(record):>12.2f}%")
    if not attendance:
        print("No students have been added.")

def below_threshold(threshold):
    print(f"\nStudents below {threshold:g}% attendance:")
    below = [name for name, record in attendance.items() if percentage(record) < threshold]
    if below:
        for name in below:
            print(f"{name}: {percentage(attendance[name]):.2f}%")
    else:
        print("None")

def main():
    while True:
        print("\nATTENDANCE TRACKER")
        print("1. Add student")
        print("2. Record attendance")
        print("3. Display attendance")
        print("4. Find students below a threshold")
        print("5. Exit")
        choice = input("Enter your choice (1-5): ").strip()
        if choice == "1":
            add_student(input("Enter student name: "))
        elif choice == "2":
            name = input("Enter student name: ")
            status = input("Enter status (present/absent): ")
            record_attendance(name, status)
        elif choice == "3":
            display_attendance()
        elif choice == "4":
            try:
                threshold = float(input("Enter attendance threshold (%): "))
                if not 0 <= threshold <= 100:
                    print("Threshold must be between 0 and 100.")
                else:
                    below_threshold(threshold)
            except ValueError:
                print("Please enter a valid number.")
        elif choice == "5":
            print("Attendance tracker closed.")
            break
        else:
            print("Invalid choice. Please select a number from 1 to 5.")

if __name__ == "__main__":
    main()
