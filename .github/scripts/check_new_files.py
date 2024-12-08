import subprocess
import sys

# Define allowed directories
ALLOWED_DIRECTORIES = {"verilog", "docs", "scripts", "tests"}

# Get added files from git diff
result = subprocess.run(
    ["git", "diff", "--name-only", "--cached", "--diff-filter=A"],
    capture_output=True,
    text=True,
    check=True
)

added_files = result.stdout.strip().splitlines()

# Check if any added file is outside allowed directories
invalid_files = [
    f for f in added_files if not any(f.startswith(dir + "/") for dir in ALLOWED_DIRECTORIES)
]

if invalid_files:
    print("❌ These files are not in allowed directories:")
    for file in invalid_files:
        print(f"  - {file}")
    sys.exit(1)

print("✅ All added files are in allowed directories.")
