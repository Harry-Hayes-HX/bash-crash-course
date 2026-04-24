#!/bin/bash
# Intermediates — CTF challenge setup
# Run once: bash intermediates/setup/setup-challenges.sh
# Creates ~/bash_ctf/intermediates (or $BASEDIR).

set -e
BASEDIR="${BASEDIR:-$HOME/bash_ctf/intermediates}"
mkdir -p "$BASEDIR"
cd "$BASEDIR"

echo "Setting up Intermediate CTF challenges in $BASEDIR ..."

# --- Challenge 1: Conditionals (gatekeeper) ---
mkdir -p module1
echo "ACCESS_TOKEN: a1B2c3D4e5F6g7H8" > module1/code.txt
echo "One of these is the correct argument: allow, secret, damosmells, permit, bills-car-sucks, harryisthebest, ilovehx,  open, KellyisScary, thecubeisreallycool, NatsaSmartyPants" > module1/args.txt
cat > module1/check.sh << 'EOF'
#!/bin/bash
if [ "$1" = "harryisthebest" ]; then
  cat "$(dirname "$0")/code.txt"
else
  echo "Access denied. Try the right argument."
fi
EOF
chmod +x module1/check.sh


# --- Challenge 2: Loops (assembly line) ---
mkdir -p module2
# One character per file; zero-padded names so code.01, code.02, ... sort correctly
CODE_STR="ASSEMBLY_CODE:x9Kp2Lm7Qv4Rn8Jw3Nq5Ht8"
for i in $(seq 1 ${#CODE_STR}); do
  printf '%s' "${CODE_STR:$((i-1)):1}" > "module2/code.$(printf '%02d' "$i")"
done


# --- Challenge 3: Functions and arguments (two keys) ---
mkdir -p module3
echo "UNLOCK_CODE: 7Xr9Mn2Pv4Ks6Lw" > module3/secret.txt
# Keys are different every time; unlock only accepts keys from the last few seconds, so they must run get_keys and pass to unlock in the same command
cat > module3/get_keys.sh << 'GETKEYS'
#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
KEY1="k1_${RANDOM}_${RANDOM}"
KEY2="k2_${RANDOM}_${RANDOM}"
echo "$KEY1" > "$DIR/.keys"
echo "$KEY2" >> "$DIR/.keys"
echo "$(date +%s)" >> "$DIR/.keys"
echo "$KEY1"
echo "$KEY2"
GETKEYS
chmod +x module3/get_keys.sh
cat > module3/unlock.sh << 'UNLOCK'
#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
KEYS_FILE="$DIR/.keys"
if [ ! -f "$KEYS_FILE" ] || [ -z "$1" ] || [ -z "$2" ]; then
  echo "Need two arguments from get_keys.sh."
  exit 1
fi
K1=$(sed -n '1p' "$KEYS_FILE")
K2=$(sed -n '2p' "$KEYS_FILE")
TS=$(sed -n '3p' "$KEYS_FILE")
NOW=$(date +%s)
AGE=$((NOW - TS))
if [ "$1" = "$K1" ] && [ "$2" = "$K2" ] && [ "$AGE" -le 5 ]; then
  cat "$DIR/secret.txt"
else
  echo "Keys wrong or expired (must use get_keys output within 5 seconds)."
  exit 1
fi
UNLOCK
chmod +x module3/unlock.sh


# --- Challenge 4: Exit codes (unlock) ---
mkdir -p module4
echo "SUCCESS_CODE: 2Jh5Gt8Yq1Zn3Bx" > module4/code.txt
# run_me.sh runs YOUR script; only if your script exits 0 does it print the code
cat > module4/run_me.sh << 'EOF'
#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
if [ -z "$1" ]; then
  echo "Usage: ./run_me.sh <your_script>"
  echo "Runs your script; only prints the success code if your script exits 0."
  exit 2
fi
"$1"
CODE=$?
if [ "$CODE" -eq 0 ]; then
  cat "$DIR/code.txt"
  exit 0
fi
echo "Your script exited with $CODE. It must exit 0 to get the code."
exit 1
EOF
chmod +x module4/run_me.sh


# --- Challenge 5: Capstone (log hunter) ---
# Many dirs; only one has the report ID. Script must take search root from hint.sh, use a function, loop, conditionals, exit codes.
mkdir -p module5
for i in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20; do
  mkdir -p "module5/dir_$i"
  echo "2024-01-15 10:00 INFO Routine message" > "module5/dir_$i/log.txt"
done
echo "2024-01-15 10:00 INFO Routine
REPORT_ID: 8Wz3Qm6Jt1Hv9Np" > module5/dir_11/log.txt
# hint.sh outputs the search root (so their script must take $1 and search under it)
echo '#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
echo "$DIR"' > module5/hint.sh
chmod +x module5/hint.sh
echo "REPORT_ID: 8Wz3Qm6Jt1Hv9Np" > module5/code.txt
# run_me.sh runs their script with the search root as $1; only if it exits 0 does run_me print the code
cat > module5/run_me.sh << 'CAPEOF'
#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
if [ -z "$1" ]; then
  echo "Usage: ./run_me.sh <your_script>"
  echo "Your script will be called with one argument: the path to this directory (from hint.sh)."
  echo "It must exit 0 when it finds a line containing REPORT_ID in one of dir_*/log.txt, else exit 1."
  exit 2
fi
ROOT="$("$DIR/hint.sh")"
"$1" "$ROOT"
if [ $? -eq 0 ]; then
  cat "$DIR/code.txt"
fi
CAPEOF
chmod +x module5/run_me.sh
echo "Get the report ID by running: ./run_me.sh <your_script>. run_me calls your script with one argument (the path from hint.sh). Your script must: (1) take that path as \$1, (2) define a function that returns 0 if a file contains REPORT_ID (e.g. grep -q REPORT_ID \"\$1\"; return \$?), (3) loop over dir_*/log.txt under \$1, (4) use your function and conditionals, (5) exit 0 if REPORT_ID found, exit 1 otherwise. One of dir_01..dir_20 has the report." > module5/README.txt


# Ensure ownership if run with sudo
if [ -n "${SUDO_USER:-}" ]; then
  chown -R "$SUDO_USER:$SUDO_USER" "$BASEDIR"
fi

echo "Done! Challenges are in: $BASEDIR"
echo "  module1/       - Conditionals (gatekeeper)"
echo "  module2/      - Loops (assembly line)"
echo "  module3/       - Functions/arguments (two keys)"
echo "  module4/  - Exit codes (unlock)"
echo "  module5/   - Capstone (log hunter)"
