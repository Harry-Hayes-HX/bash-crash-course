# Lesson 2: trap and Signals

**Concepts:** **trap** (run code on exit or signal), **EXIT** and **ERR**, **cleanup** (temp files, locks).

---

## Concept 1: trap basics

**trap** runs a command or function when the shell receives a **signal** or when it **exits**. Syntax:

```bash
trap 'commands' SIGNAL
```

Common signals: **EXIT** (script or shell exiting), **ERR** (command failed, with set -e), **INT** or **SIGINT** (Ctrl+C), **TERM** (terminate).

**Small examples:**

```bash
trap 'echo "Exiting now"' EXIT
echo "Hello"
exit 0
# "Exiting now" is printed before the script exits
```

```bash
trap 'echo "Interrupted"' INT
echo "Press Ctrl+C"
sleep 10
# If you press Ctrl+C, "Interrupted" is printed, then the script exits
```

```bash
# Cleanup function
cleanup() { rm -f /tmp/myscript.$$.tmp; echo "Cleaned up"; }
trap cleanup EXIT
touch /tmp/myscript.$$.tmp
echo "Done"
# On exit (normal or error), cleanup runs and removes the temp file
```

---

## Concept 2: EXIT and ERR

| Trap target | When it runs |
|-------------|----------------|
| **EXIT** | When the script exits (normal exit, exit 1, or signal that ends the script). |
| **ERR** | When a command fails (if set -e is in effect, or with set -E in Bash so functions inherit). |

Use **EXIT** for cleanup that must always run (remove temp files, release locks). Use **ERR** to log or react to the first failing command.

**Small examples:**

```bash
trap 'echo "Cleanup on exit"' EXIT
false
echo "After false"
# With set -e, script exits at false, then EXIT trap runs
```

```bash
# Only on error (Bash: set -E so ERR is triggered in functions too)
set -E
trap 'echo "Something failed (line $LINENO)"' ERR
false
```

```bash
TMP=$(mktemp)
trap "rm -f $TMP" EXIT
echo "temp" > "$TMP"
cat "$TMP"
# On exit, $TMP is removed
```

---

## Concept 3: Cleanup patterns

Typical pattern: create a **cleanup** function that removes temp files, closes handles, or releases locks; then **trap** it on **EXIT**. Use a **single** temp dir so you can `rm -rf` it safely.

**Small examples:**

```bash
WORKDIR=$(mktemp -d)
cleanup() { rm -rf "$WORKDIR"; }
trap cleanup EXIT
cd "$WORKDIR"
touch file1 file2
# ... do work ...
# On any exit, WORKDIR is removed
```

```bash
# Multiple traps: run cleanup then another action on EXIT
cleanup() { rm -f /tmp/lock.$$; }
trap 'cleanup; echo "Bye"' EXIT
```

---

## Recap: 1, 2, 3

- **1:** `trap 'cmd' SIGNAL` — run cmd when signal or exit happens. EXIT = on exit, INT = Ctrl+C.
- **2:** EXIT runs on any exit; ERR runs when a command fails (with set -e / set -E).
- **3:** Define a cleanup function and `trap cleanup EXIT` so temp files or locks are always removed.

---

## Example 1 — Focus on 1 (trap EXIT)

Write a script that sets `trap 'echo "Exiting at line $LINENO"' EXIT`, then echoes "Step 1", then "Step 2", then exits 0. Run it and confirm the trap message appears.

---

## Example 2 — Focus on 2 (trap ERR)

Write a script with `set -e` and `trap 'echo "Command failed"' ERR`. Run a command that fails (e.g. `false`). Confirm the trap runs before the script exits.

---

## Example 3 — Focus on 3 (cleanup)

Write a script that creates a temp file with `mktemp`, traps EXIT to remove that file, writes a line to the file, cats it, then exits. Run it and then check that the temp file no longer exists (e.g. `ls /tmp/tmp.*`).

---

## Combined example — 1 + 2 + 3

Write a script that:

1. Creates a temp directory with `mktemp -d` and a cleanup function that does `rm -rf` of that directory.
2. Sets `trap cleanup EXIT`.
3. With `set -e`, `cd`s into the temp dir, creates a file, and runs one command that might fail (e.g. `grep "x" thefile || true` so the script doesn’t exit).
4. Exits 0. Confirm the temp directory is gone after the script runs.

You’ve used trap for cleanup and can add ERR for error logging. Next: [03 - Arrays and data](03-arrays-and-data.md).
