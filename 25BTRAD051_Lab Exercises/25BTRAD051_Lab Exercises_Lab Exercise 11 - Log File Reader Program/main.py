from pathlib import Path

log_file = Path("sample.log")
log_file.write_text("INFO Started\nWARNING Low disk\nERROR Failed\nINFO Retrying\nERROR Timeout\n", encoding="utf-8")
counts = {"ERROR": 0, "WARNING": 0, "INFO": 0}
try:
    for line in log_file.read_text(encoding="utf-8").splitlines():
        for level in counts:
            if level in line.upper():
                counts[level] += 1
    print("Log summary:")
    for level, count in counts.items():
        print(f"{level}: {count}")
except FileNotFoundError:
    print("Log file not found.")
