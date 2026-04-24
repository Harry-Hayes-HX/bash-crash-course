# Lesson 5: Capstone Script

This lesson ties together **conditionals**, **loops**, **functions and arguments**, and **exit codes** in one script: a small **log summary** tool that takes a directory and a pattern, finds matching log files, and reports how many lines match the pattern in each file.

---

## Goal

Write a script **log_summary.sh** that:

1. **Takes two arguments when you run it** — The first is a **directory** (e.g. a folder path like **~/logs**), and the second is a **pattern** to search for (e.g. the word **"ERROR"**). Example: `bash log_summary.sh ~/logs "ERROR"`.
2. **Checks that the inputs make sense** — If the user didn’t give two arguments, print a short usage message (e.g. “Usage: log_summary.sh &lt;directory&gt; &lt;pattern&gt;”) and **exit 2**. If the first argument isn’t actually a directory (e.g. it’s a file or doesn’t exist), print an error message and **exit 1**.
3. **Loops over every .log file in that directory** — For each file whose name ends in **.log**, count how many lines contain the pattern (you can use **grep -c**). If a file has no matches, **grep** returns exit code 1; make sure the script doesn’t stop there—for example use **|| true** after the grep, or **set +e** around it—so you can still print “0” for that file.
4. **Prints a simple report** — For each .log file, print the filename and its match count (e.g. **app.log: 3**). If there are no .log files in the directory at all, print something like “No .log files in &lt;dir&gt;” and still **exit 0** (that’s a valid result, not a failure).
5. **Exits with a clear meaning** — Use **exit 0** when the script did its job successfully, **exit 1** when something was wrong with the inputs (e.g. not a directory), and **exit 2** when the user didn’t pass the right number of arguments (usage failure).

---

## Suggested structure

Use this as a roadmap; fill in the details yourself.

1. **Shebang and strict mode** — Start with `#!/bin/bash` and (if you want) `set -e`.
2. **A usage function** — Define a function that prints a message like “Usage: &lt;scriptname&gt; &lt;directory&gt; &lt;pattern&gt;” and then exits with code 2. Call it when the user doesn’t give two arguments.
3. **Save your arguments** — Put the first argument in a variable (e.g. the directory) and the second in another (e.g. the pattern). The pattern is the text you will search for inside each log file (e.g. the user might pass **"ERROR"** to find lines that contain the word ERROR).
4. **Check the directory** — If the first argument isn’t a directory, print an error and exit 1. (You can use a conditional or a short “do this or else” pattern.)
5. **Loop over .log files** — Use a **for** loop over files in the directory whose names end in `.log`. For each file, you need to:
   - Skip it if it’s not a regular file (in case the glob behaves oddly).
   - Count how many lines contain the pattern (e.g. **grep -c**). Remember that **grep** returns exit code 1 when there are no matches—your script should not exit there; handle that case and treat it as “0 matches”.
   - Print the filename and the count (e.g. `app.log: 3`). You may find **basename** useful so you print only the filename, not the full path.
6. **“No .log files”** — If there are no .log files in the directory, your loop might not run. Consider printing a message like “No .log files in &lt;dir&gt;” in that situation and still exiting 0.

Once that’s in place, you can refine (e.g. cleaner “no .log files” handling, or ignoring subdirectories).

---

## What you’re using

| Concept | Where |
|--------|--------|
| **Conditionals** | `[ $# -lt 2 ]`, `[ -d "$DIR" ]`, `[ -f "$f" ]`, usage and validation |
| **Loops** | `for f in "$DIR"/*.log` |
| **Functions** | `usage()` |
| **Arguments** | `$0`, `$1`, `$2`, `$#` |
| **Exit codes** | `exit 0`, `exit 1`, `exit 2`, handling `grep -c` when count is 0 |
| **Robustness** | `set -e`, quoting `"$f"`, `basename` for clean output |

---

## Try it

1. Create a test dir and logs:
   ```bash
   mkdir -p ~/bash-practice/summary_test
   echo "ERROR one" > ~/bash-practice/summary_test/a.log
   echo "ERROR two" >> ~/bash-practice/summary_test/a.log
   echo "INFO" > ~/bash-practice/summary_test/b.log
   ```
2. Run: `bash log_summary.sh ~/bash-practice/summary_test "ERROR"`.
3. Expect something like: `a.log: 2`, `b.log: 0` (or “0” depending how you handle no matches).
4. Run with no args: expect usage and exit 2. Run with a non-dir: expect exit 1.

You’ve built a script that uses conditionals, loops, functions, arguments, and exit codes. Next: try the [intermediate challenges](../../REFEREE-SITE/challenges/intermediates/).
