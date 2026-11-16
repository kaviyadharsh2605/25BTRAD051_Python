import json
from pathlib import Path

file = Path("students.json")
records = [{"roll": "101", "name": "Meera", "mark": 88}, {"roll": "102", "name": "Nikhil", "mark": 74}]
file.write_text(json.dumps(records, indent=2), encoding="utf-8")
data = json.loads(file.read_text(encoding="utf-8"))
print("All records:")
for row in data:
    print(row)
found = next((r for r in data if r["roll"] == "102"), None)
print("Search roll 102:", found)
found["mark"] = 81
file.write_text(json.dumps(data, indent=2), encoding="utf-8")
print("Updated roll 102:", next(r for r in data if r["roll"] == "102"))
