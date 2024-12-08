import subprocess
import sys
import re

# Define allowed directories
ALLOWED_DIRECTORIES = {".github", "def", "docs", "gds", "lef", "lib", "mag", "sdc", "signoff", "spef", "spi", "verilog/rtl/team_projects"}

TEAM_DV_PATTERN = re.compile(r"^verilog/dv/team_[0-9][0-9]/")
TEAM_OPENLANE_PATTERN = re.compile(r"^openlane/team_[0-9][0-9]/")

# Only change commit hash if you are a member of the post-program integration team.  All others will be banished off the face of the Earth
STABLE_COMMIT_HASH = "ce80ae1e0ef540a906c214b488c46824f86659c0"  # 12/8/2024

# Get added files from git diff
result = subprocess.run(
    ["git", "diff", "--name-only", "--cached", f"{STABLE_COMMIT_HASH}"],
    capture_output=True,
    text=True,
    check=True
)

added_files = result.stdout.strip().splitlines()

# Check if any added file is outside allowed directories
invalid_files = [
    f for f in added_files 
    if not any(f.startswith(dir + "/") for dir in ALLOWED_DIRECTORIES) 
    and not TEAM_DV_PATTERN.match(f)
    and not TEAM_OPENLANE_PATTERN.match(f)
]

if invalid_files:
    print("❌ These files are not in allowed directories:")
    for file in invalid_files:
        print(f"  - {file}")
    sys.exit(1)

print("✅ All added files are in allowed directories.")
