# Lesson 4: Exit Codes and Robustness

**Concepts:** **Exit code** (`$?`), **exit** (success/failure), **set -e** (exit on first failure).

---

## Concept 1: Exit code — $?

Every command returns an **exit code** (0 = success, non‑zero = failure). The shell stores it in **$?** (only until the next command runs).

| Code | Meaning |
|------|--------|
| **0** | Success |
| **1** | General failure (often used in scripts) |
| **2** | Misuse (e.g. wrong arguments) |
| **126** | Not executable |
| **127** | Command not found |

**Small examples:**

```bash
true
echo $?
# 0

false
echo $?
# 1
```

```bash
cat /etc/hostname
echo "Exit: $?"
cat /nonexistent
echo "Exit: $?"
```

```bash
# Use in a script to react to failure
if ! grep -q "ERROR" log.txt; then
  echo "No errors found"; exit 0
else
  echo "Errors found"; exit 1
fi
```

---

## Concept 2: exit (success/failure)

**exit n** ends the script (or shell) with exit code **n**. Use **exit 0** for success and **exit 1** (or 2) for failure so other scripts or the user can detect errors.

**Small examples:**

```bash
# In a script:
if [ ! -f "$1" ]; then
  echo "File not found: $1"
  exit 1
fi
cat "$1"
exit 0
```

```bash
# Function that “returns” success/failure
check_file() {
  if [ -f "$1" ]; then exit 0; else exit 1; fi
}
check_file /etc/hostname && echo "Exists"
check_file /nonexistent || echo "Missing"
```

---

## Concept 3: set -e (exit on first failure)

**set -e** makes the script exit immediately if any command fails (non‑zero exit). Useful so one failing step doesn’t let the rest run with bad state. You can turn it off with **set +e** for a section where you expect failures and handle them with **$?** or **if**.

**Small examples:**

```bash
# Script start
set -e
cd /tmp
touch must_exist.txt
rm must_exist.txt
echo "Done"
# If cd or touch failed, script would have exited before "Done"
```

```bash
# Optional: set -u (treat unset variables as error) and set -o pipefail (pipe fails if any command in the pipe fails)
set -e
set -u
# Now undefined variables and failed pipes will stop the script
```

```bash
# Ignore failure for one command
set -e
false || true
echo "Continuing"
```

---

## Recap: 1, 2, 3

- **1:** `$?` — exit code of the last command; 0 = success.
- **2:** `exit 0` / `exit 1` — end script with a clear success/failure code.
- **3:** `set -e` — exit on first failing command; use `set +e` and `$?` where you handle errors.

---

## Example 1 — Focus on 1 ($?)

Run `ls /etc/hostname`, then `echo $?`. Run `ls /nonexistent`, then `echo $?`. Write a one-liner that runs `cat somefile` and prints “Failed” only if the exit code is non‑zero (e.g. `cat somefile; [ $? -ne 0 ] && echo "Failed"`).

---

## Example 2 — Focus on 2 (exit)

Write a script that takes one argument. If it’s not a file, print “Not a file” and **exit 1**. If it is a file, print “File: $1” and **exit 0**. Run it with a file and with a non-file; then run `echo $?` after each to see 0 or 1.

---

## Example 3 — Focus on 3 (set -e)

Write a script that does **set -e**, then **cd /tmp**, **touch test_set_e**, **echo "Created"**, **rm test_set_e**, **echo "Done"**. Run it. Then change **cd** to **cd /nonexistent** and run again — the script should stop before “Created” and the overall script exit code should be non‑zero.

---

## Combined example — 1 + 2 + 3

Write a script **safe_grep.sh** that:

1. **Turn on “exit on first failure”** — Put **set -e** at the top so the script stops as soon as any command fails. (You can also add **set -u** so the script complains if you use a variable that wasn’t set.)
2. **Check that the user gave you two arguments** — The script needs a search pattern and a filename. If the user didn’t pass two arguments (e.g. they ran the script with no arguments or only one), print a short message like “Usage: safe_grep.sh &lt;pattern&gt; &lt;file&gt;” and then **exit 2** so the script exits with a “usage error” code.
3. **Run grep and remember its exit code** — Run **grep** with the first argument as the pattern and the second as the file. Right after that, save the exit code in a variable (e.g. **EXIT=$?**). If you’re using **set -e**, put **set +e** before the grep so the script doesn’t exit when grep finds no matches (exit code 1); then you can check the code yourself.
4. **Decide what to do based on that exit code** — If the code is **0**, grep found matches: print “Matches found” and **exit 0**. If it’s **1**, grep found no matches: print “No matches” and **exit 1**. If it’s **2**, something went wrong (e.g. file not found): print “Error” and **exit 2**.

You’ve used **$?**, **exit**, and **set -e** / **set +e**. Next: [05 - Capstone script](05-capstone-script.md).
