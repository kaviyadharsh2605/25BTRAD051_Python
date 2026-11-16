import csv
from io import StringIO

source = "name,basic,allowance,deduction\nAsha,30000,5000,2000\nBala,25000,4000,1500\n"
rows = csv.DictReader(StringIO(source))
print("PAYROLL SUMMARY")
for row in rows:
    gross = int(row["basic"]) + int(row["allowance"])
    net = gross - int(row["deduction"])
    print(f"{row['name']}: Gross Rs.{gross}, Deduction Rs.{row['deduction']}, Net Rs.{net}")
