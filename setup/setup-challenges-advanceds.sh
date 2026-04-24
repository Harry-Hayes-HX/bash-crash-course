#!/bin/bash
# Advanced — CTF challenge setup
# Creates ~/bash_ctf/advanceds (or $BASEDIR).

set -e
BASEDIR="${BASEDIR:-$HOME/bash_ctf/advanceds}"
mkdir -p "$BASEDIR"
cd "$BASEDIR"

echo "Setting up Advanced CTF challenges in $BASEDIR ..."

# --- Challenge 1: Error handling (fail safe) ---
# Tests: (1) input validation — script must exit 2 when no arg, 1 when arg is not a dir; (2) strict mode + handling failure — task.sh fails until 'ready' exists, script must handle that and retry; (3) success path prints code.
mkdir -p module1
echo "SAFE_CODE: 5Tm9Kp2Lm7Qv4Rn8" > module1/code.txt
cat > module1/task.sh << 'TASK'
#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
if [ ! -f "$DIR/ready" ]; then
  echo "Not ready. Create $DIR/ready and run me again." >&2
  exit 1
fi
cat "$DIR/code.txt"
exit 0
TASK
chmod +x module1/task.sh
# run_me.sh: runs the user script with no args (expect exit 2), bad path (expect exit 1), then good path (expect 0 and SAFE_CODE in output)
cat > module1/run_me.sh << 'RUNME'
#!/bin/bash
SCRIPT="${1:?Usage: ./run_me.sh <your_script>}"
DIR="$(cd "$(dirname "$0")" && pwd)"
# Test 1: no args → script must exit 2 (usage)
"$SCRIPT" 2>/dev/null; R=$?
if [ "$R" -ne 2 ]; then
  echo "Fail: with no args your script should exit 2 (got $R)."
  exit 1
fi
# Test 2: invalid path (not a directory) → script must exit 1
"$SCRIPT" /nonexistent/module1 2>/dev/null; R=$?
if [ "$R" -ne 1 ]; then
  echo "Fail: with invalid dir your script should exit 1 (got $R)."
  exit 1
fi
# Test 3: correct path → must exit 0 and print the code
OUT=$(mktemp)
"$SCRIPT" "$DIR" > "$OUT" 2>&1; R=$?
if [ "$R" -ne 0 ]; then
  echo "Fail: with correct dir your script should exit 0 (got $R)."
  cat "$OUT"
  rm -f "$OUT"
  exit 1
fi
if ! grep -q "SAFE_CODE:" "$OUT"; then
  echo "Fail: output should contain SAFE_CODE:..."
  cat "$OUT"
  rm -f "$OUT"
  exit 1
fi
rm -f "$OUT"
echo "Success. Code was printed above."
RUNME
chmod +x module1/run_me.sh
echo "Your script gets one argument: a path to this directory. It must:
1) Validate: if no argument or argument is not a directory, print an error (e.g. usage) and exit 2 (no arg) or 1 (bad path).
2) When the argument is valid: run task.sh (it will fail until 'ready' exists), handle the failure so your script does not exit, create ready in this dir, then run task.sh again so it prints the code.
run_me.sh tests all three: no args → exit 2; bad path → exit 1; correct path → exit 0 and print SAFE_CODE." > module1/README.txt

# --- Challenge 2: trap (clean exit) ---
mkdir -p module2
echo "TRAP_CODE: 8Wz3Qm6Jt1Hv9Np" > module2/code.txt
cat > module2/run_me.sh << 'EOF'
#!/bin/bash
# code.txt is hidden while your script runs; we reveal it only when we stop your script.
# The code must be printed in an exit handler (trap on EXIT)—there is no other way to read it.
if [ -z "$1" ]; then
  echo "Usage: ./run_me.sh <your_script>"
  echo "Your script gets this directory as \$1. The runner will stop your script after a moment; when it exits, the code must be printed (use a trap)."
  exit 2
fi
DIR="$(cd "$(dirname "$0")" && pwd)"
OUT="$(mktemp)"
# Hide code.txt so the only way to read it is in an EXIT trap (after we reveal it and kill the script)
CODE_FILE="$DIR/code.txt"
[ -f "$CODE_FILE" ] && CODE_CONTENT="$(cat "$CODE_FILE")" && rm -f "$CODE_FILE"
"$1" "$DIR" > "$OUT" 2>&1 &
PID=$!
sleep 1
# Reveal code.txt, then stop the script so the trap runs and can read it
printf '%s' "$CODE_CONTENT" > "$CODE_FILE"
kill "$PID" 2>/dev/null
wait "$PID" 2>/dev/null
cat "$OUT"
grep -q "TRAP_CODE:" "$OUT" && echo "Success."
rm -f "$OUT"
# Leave code.txt in place for inspection
EOF
chmod +x module2/run_me.sh
echo "Run: ./run_me.sh <your_script>. While your script runs, code.txt does not exist in this directory; the runner reveals it only when it stops your script. You must use an exit handler (trap on EXIT) to print the code—there is no other way." > module2/README.txt

# --- Challenge 3: Arrays (line up) ---
mkdir -p module3
JUNK=("ARRAY_TOKEN: (ignore)" "ARRAY_TOKEN: nope" "ARRAY_TOKEN: skip this" "ARRAY_TOKEN: junk" "ARRAY_TOKEN: not here" "ARRAY_TOKEN: ignore" "ARRAY_TOKEN: ---" "ARRAY_TOKEN: nothing to see" "ARRAY_TOKEN: move along" "ARRAY_TOKEN: n/a" "ARRAY_TOKEN: 0xdead" "ARRAY_TOKEN: 0xbeef" "ARRAY_TOKEN: invalid" "ARRAY_TOKEN: placeholder" "ARRAY_TOKEN: dummy" "ARRAY_TOKEN: skip" "ARRAY_TOKEN: null" "ARRAY_TOKEN: unused" "ARRAY_TOKEN: discard" "ARRAY_TOKEN: ---")
for i in $(seq 0 1537); do
  if [ "$i" -eq 542 ]; then
    echo "Line 542 ARRAY_TOKEN: 2Jh5Gt8Yq1Zn3Bx"
  else
    echo "Line $i ${JUNK[$((RANDOM % ${#JUNK[@]}))]}"
  fi
done > module3/array.txt
echo "My FAVOURITE book is The Hitchhiker's Guide to the Galaxy. Wish i could remember what number was the answer to life, the universe, and everything... I wonder what would happen if we added 500 to it?" >> module3/FavouriteBook.txt

# --- Challenge 4: getopts (options) ---
  mkdir -p module4
echo "OPTIONS_CODE: 4Fc7Vn9Rx2Km5Lp" > module4/code.txt
cat > module4/run_me.sh << 'EOF'
#!/bin/bash
# Runs your script with -f code.txt. If your script exits 0 and parsed -f, run_me confirms.
if [ -z "$1" ]; then
  echo "Usage: ./run_me.sh <your_script>"
  exit 2
fi
DIR="$(cd "$(dirname "$0")" && pwd)"
"$1" -f "$DIR/code.txt"
[ $? -eq 0 ] && echo "Success."
EOF
chmod +x module4/run_me.sh

# --- Challenge 5: Capstone (full stack) ---
mkdir -p module5/data
echo "CAPSTONE_TOKEN: 7Xr9Mn2Pv4Ks6Lw" > module5/data/secret.txt
echo "data/secret.txt" > module5/files.txt
echo "data/other.txt" >> module5/files.txt
echo "data/notes.txt" >> module5/files.txt
echo "other" > module5/data/other.txt
echo "notes here" > module5/data/notes.txt
cat > module5/run_me.sh << 'EOF'
#!/bin/bash
# data/secret.txt is hidden while your script runs; we reveal it only when we stop your script.
# Your script must use: set -e, trap on EXIT (to cat the token when killed), getopts -d, and filter an array (from files.txt) to find which path contains CAPSTONE_TOKEN.
if [ -z "$1" ]; then
  echo "Usage: ./run_me.sh <your_script>"
  echo "Your script is run with -d <this_dir>. It must use set -e, trap EXIT, getopts -d, and an array (mapfile from files.txt) filtered to the file containing CAPSTONE_TOKEN. We stop your script after a moment; the token must be printed in your EXIT trap."
  exit 2
fi
DIR="$(cd "$(dirname "$0")" && pwd)"
OUT="$(mktemp)"
SECRET="$DIR/data/secret.txt"
[ -f "$SECRET" ] && SECRET_CONTENT="$(cat "$SECRET")" && rm -f "$SECRET"
# If script has no path (e.g. solution.sh), run from current dir so ./run_me.sh solution.sh works
SCRIPT="$1"; case "$SCRIPT" in /*|*/*) ;; *) SCRIPT="./$SCRIPT" ;; esac
"$SCRIPT" -d "$DIR" > "$OUT" 2>&1 &
PID=$!
sleep 1
printf '%s' "$SECRET_CONTENT" > "$SECRET"
kill "$PID" 2>/dev/null
wait "$PID" 2>/dev/null
cat "$OUT"
grep -q "CAPSTONE_TOKEN:" "$OUT" && echo "Success."
rm -f "$OUT"
EOF
chmod +x module5/run_me.sh
# Ownership if run with sudo
if [ -n "${SUDO_USER:-}" ]; then
  chown -R "$SUDO_USER:$SUDO_USER" "$BASEDIR"
fi

echo "Done! Challenges are in: $BASEDIR"
echo "  module1/ - Error handling (fail safe)"
echo "  module2/          - trap and signals (clean exit)"
echo "  module3/        - Arrays (line up)"
echo "  module4/       - getopts (options)"
echo "  module5/      - Capstone (full stack)"
echo "Challenge briefs: REFEREE-SITE/challenges/advanceds/"
