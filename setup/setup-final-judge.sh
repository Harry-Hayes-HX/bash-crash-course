#!/bin/bash
# Final Challenge — Judge environments
# Run once: bash setup/setup-final-judge.sh
# Creates ~/bash_ctf/final_judge with one directory per condition group.
# Cd into the group you want and run the test commands (see README in each group).

set -e
BASEDIR="${BASEDIR:-$HOME/bash_ctf/final_judge}"
mkdir -p "$BASEDIR"
cd "$BASEDIR"

echo "Setting up Final Challenge judge environments in $BASEDIR ..."

# --- Group 0 — Happy path (perfect conditions) ---
mkdir -p group0
echo "Sample file A" > group0/source1.txt
echo "Sample file B" > group0/source2.txt
G0="$(cd group0 && pwd)"
printf '%s\n' "$G0/source1.txt" "$G0/source2.txt" > group0/config.txt
mkdir -p group0/out
cat > group0/README.txt << 'EOF'
Happy path — script should succeed.
  SCRIPT=/path/to/their_script.sh
  cd group0
  $SCRIPT -c config.txt -d ./out
Expected: processes both files, exit 0, clear success.
EOF

# --- Group 1 — User error (wrong/missing args) ---
mkdir -p group1
cat > group1/README.txt << 'EOF'
User error — no files needed; test invocations only.
  SCRIPT=/path/to/their_script.sh
  cd group1

  $SCRIPT
  $SCRIPT -c /tmp/config.txt
  $SCRIPT -d /tmp/out
  $SCRIPT -c
  $SCRIPT -c -d /tmp/out
  $SCRIPT -x foo
Expected each: clear usage/error, non-zero exit.
EOF

# --- Group 2 — Missing or invalid config ---
mkdir -p group2
mkdir -p group2/out
touch group2/config.txt
chmod 000 group2/config.txt
mkdir -p group2/not_a_file
cat > group2/README.txt << EOF
Missing or invalid config.
  SCRIPT=/path/to/their_script.sh
  cd group2

  $SCRIPT -c /nonexistent/config.txt -d ./out
  $SCRIPT -c config.txt -d ./out
  $SCRIPT -c not_a_file -d ./out
Expected each: clear error, non-zero exit.
( config.txt exists but is chmod 000; not_a_file is a directory )
EOF

# --- Group 3 — Filesystem and permissions ---
mkdir -p group3
mkdir -p group3/out
echo "/nonexistent/source.txt" > group3/config_nonexistent.txt
touch group3/real.txt
echo "$(cd group3 && pwd)/real.txt" > group3/config_real.txt
cat > group3/README.txt << 'EOF'
Filesystem and permissions. Run from group3; SCRIPT=/path/to/their_script.sh

  3.1 — config lists nonexistent source:
    cp config_nonexistent.txt config.txt
    $SCRIPT -c config.txt -d ./out

  3.2 — dest not writable:
    chmod 555 out
    echo /etc/hosts > config.txt
    $SCRIPT -c config.txt -d ./out

  3.3 — config lists a directory (if invalid for their design):
    echo "." > config.txt
    $SCRIPT -c config.txt -d ./out

  3.4 — source exists but not readable:
    cp config_real.txt config.txt
    chmod 000 real.txt
    $SCRIPT -c config.txt -d ./out

Reset out between tests if needed: chmod 755 out
EOF

# --- Group 4 — Signals and interruption ---
mkdir -p group4
printf '/etc/hosts\n%.0s' {1..50} > group4/config.txt
mkdir -p group4/out
cat > group4/README.txt << 'EOF'
Signals — script should exit cleanly when interrupted.
  SCRIPT=/path/to/their_script.sh
  cd group4

  $SCRIPT -c config.txt -d ./out &
  PID=$!
  sleep 1
  kill -INT $PID
  wait $PID

  # Or: kill -TERM $PID
Expected: clean exit, no trace, optional cleanup.
EOF

# --- Group 5 — Empty or malformed data ---
mkdir -p group5
mkdir -p group5/out
touch group5/real.txt
touch group5/empty.txt
printf '\n\n  \n' > group5/blanks.txt
REAL5="$(cd group5 && pwd)/real.txt"
printf '%s\n\n/nonexistent.txt\n' "$REAL5" > group5/config_mixed.txt
cat > group5/README.txt << 'EOF'
Empty or malformed config data.
  SCRIPT=/path/to/their_script.sh
  cd group5

  $SCRIPT -c empty.txt -d ./out
  $SCRIPT -c blanks.txt -d ./out
  $SCRIPT -c config_mixed.txt -d ./out
Expected: no crash; clear message or partial success / clear errors.
EOF

# --- Group 6 — Environment and context ---
mkdir -p group6
mkdir -p group6/sub
mkdir -p group6/out
echo "should_not_exist_here.txt" > group6/config.txt
cat > group6/README.txt << 'EOF'
Environment and context — relative vs absolute, different cwd.
  SCRIPT=/path/to/their_script.sh

  6.1 — run from sub so relative path in config does not exist from cwd:
    cd group6/sub && $SCRIPT -c ../config.txt -d ../out

  6.2 — absolute then relative:
    cd group6
    $SCRIPT -c "$(pwd)/config.txt" -d "$(pwd)/out"
    $SCRIPT -c config.txt -d out

  6.3 — mix relative config and absolute dest (or vice versa):
    cd group6
    $SCRIPT -c config.txt -d "$(pwd)/out"
Expected: consistent behaviour, no crash.
EOF

# --- Top-level README ---
cat > "$BASEDIR/README.txt" << EOF
Final Challenge — Judge environments
=====================================

Base dir: $BASEDIR

  group0  — Happy path (perfect conditions)
  group1  — User error (wrong/missing arguments)
  group2  — Missing or invalid config
  group3  — Filesystem and permissions
  group4  — Signals and interruption
  group5  — Empty or malformed data
  group6  — Environment and context

Pick which scenario to give: cd into the group (e.g. cd group3), set
  SCRIPT=/path/to/participant_script.sh
then follow the commands in that group's README.txt.

Detailed runbook: REFEREE-SITE/challenges/final-challenge/JUDGE_RUNBOOK.md
EOF

# Ownership if run with sudo
if [ -n "${SUDO_USER:-}" ]; then
  chown -R "$SUDO_USER:$SUDO_USER" "$BASEDIR"
fi

echo "Done! Judge environments are in: $BASEDIR"
echo "  cd $BASEDIR/groupN   then read README.txt and run the test commands with SCRIPT=..."
echo "  Full runbook: REFEREE-SITE/challenges/final-challenge/JUDGE_RUNBOOK.md"
