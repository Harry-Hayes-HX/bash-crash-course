#!/bin/bash
# Bash Crash Course — CTF challenge setup
# Run once on your Linux instance: bash setup/setup-challenges.sh
# Creates ~/bash_ctf/basics (or $BASEDIR) with all challenge data.

set -e
BASEDIR="${BASEDIR:-$HOME/bash_ctf/basics}"
mkdir -p "$BASEDIR"
cd "$BASEDIR"

echo "Setting up Bash CTF challenges in $BASEDIR ..."

# ------------------------------------------- Module 1: Navigation (labyrinth) -------------------------------------------
# Maze: start -> hall -> corridor -> vault (code.txt). Extra branches are dead ends.
mkdir -p module1/hall/corridor/vault
echo "CENTER_CODE: 9Kp2xLm7Qv4Rn8Jw" > module1/hall/corridor/vault/code.txt
# Dead ends and dummy branches
mkdir -p module1/hall/dead_end
echo "Dead end. Turn back." > module1/hall/dead_end/readme.txt
mkdir -p module1/hall/corridor/wrong_way
echo "Nothing here. Try vault." > module1/hall/corridor/wrong_way/readme.txt
mkdir -p module1/hall/anteroom
echo "Empty. Go back." > module1/hall/anteroom/readme.txt
mkdir -p module1/hall/storage
echo "Storage - no code here." > module1/hall/storage/notes.txt
echo "Inventory: empty" > module1/hall/storage/inventory.txt
mkdir -p module1/hall/archive
echo "Archived. Nothing to see." > module1/hall/archive/readme.txt
echo "Old logs" > module1/hall/archive/logs.txt
mkdir -p module1/hall/corridor/side_room
echo "Side room - wrong direction." > module1/hall/corridor/side_room/readme.txt
mkdir -p module1/hall/corridor/loop
echo "This way is a dead end." > module1/hall/corridor/loop/hint.txt
mkdir -p module1/hall/back_office
echo "Back office - no code." > module1/hall/back_office/readme.txt
echo "TODO: nothing" > module1/hall/back_office/todo.txt
mkdir -p module1/hall/corridor/vault/old_vault
echo "Old vault - code is in parent (vault)." > module1/hall/corridor/vault/old_vault/readme.txt
mkdir -p module1/hall/lobby
echo "Lobby - start from module1, not here." > module1/hall/lobby/readme.txt
mkdir -p module1/hall/corridor/junction
echo "Junction. Try vault, not here." > module1/hall/corridor/junction/readme.txt
echo "Module 1 challenge: start in module1, use ls and cd to reach the deepest folder. Submit the code you find." > module1/README.txt




# ------------------------------------------- Module 2: Files (lost memo) -------------------------------------------
mkdir -p module2/inbox
printf '%s' 'MEMO_ID: ' > module2/inbox/memo.part1
printf '%s' '3Nq5yHt8' > module2/inbox/memo.part2
printf '%s' 'Wz1Bc6Fd' > module2/inbox/memo.part3
echo "Decoy line" > module2/inbox/junk.txt
echo "Another decoy" > module2/inbox/notes.txt
echo "Instructions: The memo is in memo.part1, memo.part2, memo.part3. Concatenate them in that order (e.g. cat) to get the memo ID on one line. Ignore decoys." > module2/README.txt



# ------------------------------------------- Module 3: Find and grep (needle in haystack) -------------------------------------------
mkdir -p module3/logs module3/logs/2024/01 module3/logs/2024/02
for i in $(seq 1 40); do
  echo "2024-01-15 10:00 INFO Request $i processed" > "module3/logs/app_$i.log"
done
for i in $(seq 1 35); do
  echo "2024-01-16 09:00 INFO Event $i" > "module3/logs/2024/01/day_$i.log"
done
for i in $(seq 1 35); do
  echo "2024-02-01 11:00 WARN Check $i" > "module3/logs/2024/02/feb_$i.log"
done
# Decoy: LOG_REF but not the real token
echo "2024-01-15 10:00 INFO Startup
LOG_REF: (invalid - use the one with the real code)" > module3/logs/app_0.log
# Real token in a file in a subdir
echo "2024-01-16 14:22 ERROR Timeout
LOG_REF: 7Xr9Mn2Pv4Ks6Lw" > module3/logs/2024/01/day_23.log
echo "Module 3: One of the log files under module3/logs (including subdirs) contains a line with LOG_REF and the real code. Use find and/or grep." > module3/README.txt



# ------------------------------------------- Module 4: Permissions (locked door; code file owned by root so chown is required when run with sudo) -------------------------------------------
mkdir -p module4
echo "ACCESS_CODE: 2Jh5Gt8Yq1Zn3Bx" > module4/secret.txt
echo "DECOY: not the code" > module4/secret_backup.txt
chmod 000 module4/secret.txt
chmod 000 module4/secret_backup.txt
# When run with sudo: make the code file owned by root so learner must use sudo chown then chmod
if [ "$(id -u)" -eq 0 ]; then
  chown root:root module4/secret.txt
fi
echo "Module 4: The access code is in one of the locked files here. The file that contains ACCESS_CODE may be owned by root; use ls -l, then sudo chown and chmod to read it." > module4/README.txt



# ------------------------------------------- Module 5: Variables and scripts (script only prints token when variable is set) -------------------------------------------
# path.txt contains a random key. run_me.sh only prints the token if SECRET_PATH equals that key. The token is NOT in any file — only the script can output it. So the only way to get the token is SECRET_PATH=$(cat path.txt) ./run_me.sh (variable required).
mkdir -p module5
KEY="$(head -c 16 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c 16)"
echo "$KEY" > module5/path.txt
cat > module5/run_me.sh << RUNME
#!/bin/bash
if [ "\${SECRET_PATH:-}" = "$KEY" ]; then
  echo "PATH_TOKEN: 4Fc7Vn9Rx2Km5Lp"
  exit 0
fi
echo "Usage: read path.txt into SECRET_PATH, then run me. Example: export SECRET_PATH=\$(cat path.txt); ./run_me.sh  or  SECRET_PATH=\$(cat path.txt) ./run_me.sh" >&2
exit 1
RUNME
chmod +x module5/run_me.sh
echo "The script run_me.sh will only print the token if you run it with SECRET_PATH set to the single line in path.txt. Use export SECRET_PATH=\$(cat path.txt) then ./run_me.sh, or SECRET_PATH=\$(cat path.txt) ./run_me.sh. The token is not in any file you can cat — only the script can output it." > module5/README.txt



# ------------------------------------------- Module 6: Capstone (help desk hero) -------------------------------------------
# Many archive date folders; only 2024-01-15 has the real (locked) report
ARCH_DATES="2023-06-01 2023-09-15 2023-11-20 2024-01-01 2024-01-08 2024-01-10 2024-01-14 2024-01-15 2024-01-16 2024-01-20 2024-02-01 2024-02-05"
mkdir -p module6/logs module6/reports
for d in $ARCH_DATES; do mkdir -p "module6/archive/$d"; done
# Multiple logs with noise; only some ERROR lines give the real clue
echo "2024-01-15 09:00 INFO System OK
2024-01-15 09:15 WARN High memory usage
2024-01-15 09:50 ERROR Report written to archive/2024-01-14 (superseded)
2024-01-15 10:00 ERROR Disk space critical - report written to archive/2024-01-15 ref: final_report
2024-01-15 10:01 INFO Alert sent
2024-01-15 10:02 ERROR Backup failed (ignore - use archive ref above)" > module6/logs/system.log
echo "2024-01-15 10:05 INFO User login
2024-01-15 10:10 WARN High CPU
2024-01-15 10:12 ERROR Timeout on db query
2024-01-15 10:15 INFO Cache cleared" > module6/logs/app.log
echo "2024-01-15 09:30 ERROR Sync failed
2024-01-15 10:00 INFO Archive sweep started
2024-01-15 10:01 ERROR Permission denied writing to /tmp" > module6/logs/backup.log
echo "2024-01-15 08:00 INFO Cron job started
2024-01-15 08:05 ERROR Script not found
2024-01-15 10:00 INFO Daily report generated" > module6/logs/cron.log
# Archive README
echo "Archived reports by date (YYYY-MM-DD)." > module6/archive/README.txt
# Dummy date folders: filler text files (no report code, no locked file)
for d in 2023-06-01 2023-09-15 2023-11-20 2024-01-01 2024-01-08 2024-01-10 2024-01-14 2024-01-16 2024-01-20 2024-02-01 2024-02-05; do
  echo "Summary - no critical issues for $d." > "module6/archive/$d/summary.txt"
  echo "Legacy report. Superseded by final_report." > "module6/archive/$d/old_report.txt"
  echo "No critical data. Report empty or N/A." > "module6/archive/$d/final_report.txt"
  echo "Audit log $d - routine only." > "module6/archive/$d/audit.txt"
  echo "Notes for $d - nothing to escalate." > "module6/archive/$d/notes.txt"
done
# Real report folder: decoys + one locked final_report with the report ID
echo "Summary only - see final_report for details." > module6/archive/2024-01-15/summary.txt
echo "Legacy format - superseded by final_report." > module6/archive/2024-01-15/old_report.txt
echo "REPORT_ID: 8Wz3Qm6Jt1Hv9Np" > module6/archive/2024-01-15/final_report.txt
chmod 000 module6/archive/2024-01-15/final_report.txt
echo "Audit log 2024-01-15 - see final_report for critical section." > module6/archive/2024-01-15/audit.txt
echo "Notes - critical report generated, check final_report." > module6/archive/2024-01-15/notes.txt
# Hint is vague (no exact path)
echo "Critical report is in the archive under the date mentioned in the ERROR that says 'report written to archive/...'." > module6/reports/hint.txt
echo "Module 6: Grep logs for ERROR, find which path/date is the report. Navigate there, fix permissions on the report file, cat it." > module6/README.txt

# Ensure user owns everything (in case run with sudo or different user)
if [ -n "$SUDO_USER" ]; then
  chown -R "$SUDO_USER:$SUDO_USER" "$BASEDIR"
  # Module 4: keep secret.txt owned by root so the challenge requires chown
  if [ "$(id -u)" -eq 0 ]; then
    chown root:root "$BASEDIR/module4/secret.txt"
  fi
fi

echo "Done! Challenges are in: $BASEDIR"
echo "  module1/ - Navigation (labyrinth)"
echo "  module2/ - Files (lost memo)"
echo "  module3/ - Find & grep (needle in haystack)"
echo "  module4/ - Permissions (locked door)"
echo "  module5/ - Variables (secret path)"
echo "  module6/ - Capstone (help desk hero)"
echo "Challenge briefs: REFEREE-SITE/challenges/basics/"
