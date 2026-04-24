# Module 6: Help Desk Scenario — Putting It All Together

This module ties together **navigation (pwd, ls, cd)**, **files (view, create, copy)**, **finding and filtering (find, grep, pipes)**, **permissions (ls -l)**, and **a simple script (variables, echo)** in one realistic workflow.

---

## Scenario

A user reports: *“My machine is slow and I think something is filling the disk. Can you check for big files and any errors in the logs?”*

You will:

1. Navigate to a safe practice area and create a “logs” folder.
2. Simulate a few log files and a “large” file.
3. Find large files and search logs for “ERROR”.
4. Check who you are and permissions on the files.
5. Run a small script that summarizes findings into a report.

Use your **home directory** and **~/bash-practice** (or similar) so you don’t touch real system paths.

#ENGINEER SETUP GUIDE

---

```bash
cd ~
pwd
mkdir -p bash-practice/logs
cd bash-practice
pwd
ls -l

# One log with mixed messages
echo "2024-01-15 09:00 INFO Application started" > logs/app.log
echo "2024-01-15 09:05 ERROR Disk space low" >> logs/app.log
echo "2024-01-15 09:10 INFO Backup started" >> logs/app.log
echo "2024-01-15 09:15 ERROR Timeout connecting" >> logs/app.log

# Another log
echo "2024-01-15 10:00 ERROR Failed to write cache" > logs/system.log
echo "2024-01-15 10:01 INFO Retry succeeded" >> logs/system.log

# A “big” file (we'll use a small one for practice)
dd if=/dev/zero of=bigfile.dat bs=1M count=1 2>/dev/null || echo "large file content here" > bigfile.dat
```

---

## Step 1: Find large files and search for errors (Module 3)

---

## Step 2: Permissions and user (Module 4)

Note which user owns the files and whether they’re readable. If you see `-rw-r--r--`, the owner can read/write; others can read. That’s enough for “viewing logs” and “seeing big files.”

---

## Step 3: Write a small “report” script that will:
Print who's running the script, and write that to the report file
Print the file path for any files over 50 bytes, and writes that to the report
Prints any errors from any log files, and writes that to the report
Prints the number of errors from any log files, and writes that to the report
Prints where the report was written to

---

## Summary

You’ve:

- Used **pwd**, **ls**, **cd** to move around and create a folder.
- Used **echo**, **cat**, **ls -l** to create and view files.
- Used **find** for “big” files and **grep** (with pipes) for “ERROR” in logs.
- Used **whoami**, **id**, **ls -l** to check user and permissions.
- Run a **script** that combined variables, echo, find, grep, and piping to produce a single report file.

On a real machine you’d point the script at real log directories (e.g. `/var/log`) and use larger size thresholds (e.g. `-size +100M`), and run it with appropriate permissions. The same ideas apply.

---

**Next steps:** Keep [QUICK-REFERENCE.md](QUICK-REFERENCE.md) nearby when you’re on the command line, and re-run this scenario (or parts of it) until it feels familiar.