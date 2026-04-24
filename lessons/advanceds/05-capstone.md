# Lesson 5: Capstone — Robust Script

This lesson ties **error handling**, **trap**, **arrays**, and **getopts** into one script: a small **batch processor** that accepts options, reads a list of files (or paths) into an array, and processes each with cleanup on exit.

---

## Goal

Write a script **batch_process.sh** that:

1. **Options:** **-d directory** (required), **-e extension** (optional, default **.log**), **-v** (verbose). Use getopts and validate **-d** and that the directory exists.
2. **Strict mode:** Start with **set -euo pipefail** (or **set -eu** if pipefail causes issues with your pipeline).
3. **Cleanup:** Create a temp file or dir for a “run log”; **trap** a cleanup function on **EXIT** to remove it.
4. **Data:** Use **mapfile** (or a loop) to fill an array with the paths of files under **$directory** matching ***.${extension}** (e.g. **find ... -name "*.log"**). If the array is empty, print a message and exit 0.
5. **Process:** Loop over the array (by index or value) and for each file run a simple “process” (e.g. **wc -l** and append the result to the run log, or echo to the log). On error you can either let set -e exit (then trap runs) or handle per-file with **|| true** and log failures.
6. **Exit:** Exit 0. The EXIT trap runs and cleans up the temp file/dir.

---

## Suggested structure

A possible order of steps (you fill in the details):

1. **Shebang and strict mode** — `set -euo pipefail` (or `set -eu`).
2. **Cleanup and trap** — Define a function that removes your temp run log (or temp dir). Register it with **trap … EXIT**. Create the temp file/dir (e.g. with **mktemp**) and store its path in a variable the cleanup function can use.
3. **Defaults** — Initialize variables for directory, extension (e.g. `.log`), and verbose flag.
4. **getopts loop** — Parse **-d** (required, value = directory), **-e** (optional, value = extension), **-v** (flag), **-h** (print usage and exit 0). After the loop, **shift** so **$1** is the first non-option argument.
5. **Validation** — Require **-d** to be set and that it is an existing directory. If not, print a clear message and exit 1.
6. **Build the array** — Use **find** (or a loop) to get files under the directory matching the extension. Read them into an array (e.g. **mapfile** or a loop). If the array is empty, print a message and exit 0.
7. **Process each file** — Loop over the array; for each file run your “process” (e.g. **wc -l**) and append the result to the run log. Decide how to handle per-file errors (e.g. **|| true** so one failure doesn’t stop the script).
8. **Done** — Print something like how many files were processed, then exit 0. The EXIT trap will run and remove the temp file/dir.

---

## What you're using

| Concept | Where |
|--------|--------|
| **Error handling** | set -euo pipefail, validation of -d and directory |
| **trap** | cleanup on EXIT, remove RUNLOG |
| **Arrays** | mapfile, "${files[@]}", "${#files[@]}" |
| **getopts** | -d, -e, -v, -h, OPTARG, shift after loop |

---

## Try it

1. Create a test dir and some .log files: **mkdir -p /tmp/batchtest; touch /tmp/batchtest/{a,b,c}.log**
2. Run: **./batch_process.sh -d /tmp/batchtest -v**
3. Run with **-e .txt** and no matching files to see the “No *.txt files” exit.
4. Run with **-d /nonexistent** to see validation fail.

You’ve built a script that uses strict mode, trap, arrays, and getopts. Next: try the [advanced challenges](../../REFEREE-SITE/challenges/advanceds/).
