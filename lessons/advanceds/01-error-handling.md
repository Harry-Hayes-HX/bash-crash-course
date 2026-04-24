# Lesson 1: Error Handling and Defensive Scripting

**Concepts:** **set -e, set -u, set -o pipefail** (strict mode), **validating inputs** before use, **handling failures** explicitly with `||` and `if`.

---

## Concept 1: Strict mode — set -e, set -u, pipefail

Making the script **exit on first error** and **treat unset variables as errors** avoids silent mistakes.

| Option | Effect |
|--------|--------|
| **set -e** | Exit immediately if a command fails (non-zero exit). |
| **set -u** | Treat **unset** variables as an error (e.g. typo in `$VAR`). |
| **set -o pipefail** | A pipeline fails if **any** command in it fails (not just the last). |

Often used together at the top of a script:

```bash
#!/bin/bash
set -euo pipefail
```

**Small examples:**

```bash
# Without set -e: script keeps going after a failure
false
echo "Still here"

# With set -e: script exits at 'false'
set -e
false
echo "Never runs"
```

```bash
# set -u: unset variable is an error
set -u
echo "$NOSUCHVAR"   # script exits with "unbound variable"
```

```bash
# pipefail: without it, "false | true" exits 0 (last command succeeded)
set -o pipefail
false | true   # pipeline fails, script exits
```

---

## Concept 2: Validating inputs before use

Before using a path or argument, **check** it exists, is the right type, or is non-empty. That avoids cryptic errors later.

| Check | Example |
|-------|--------|
| Argument provided | `[ -z "${1:-}" ] && { echo "Usage: $0 <file>"; exit 1; }` |
| File exists and is regular | `[ -f "$1" ] || { echo "Not a file: $1"; exit 1; }` |
| Directory exists | `[ -d "$DIR" ] || { echo "No such dir: $DIR"; exit 1; }` |
| Variable set (with set -u) | Use `${VAR:-default}` or check before use |

**Small examples:**

```bash
# Require one argument
if [ $# -lt 1 ]; then
  echo "Usage: $0 <path>"
  exit 1
fi
[ -f "$1" ] || { echo "Not a file: $1"; exit 1; }
cat "$1"
```

```bash
# Safe default for optional variable
LOGDIR="${LOGDIR:-/var/log}"
echo "Using $LOGDIR"
```

---

## Concept 3: Handling failures explicitly

Sometimes you **don’t** want the script to exit on a failure (e.g. optional step). Use **`|| true`** to ignore failure, or **`if ! command`** to branch.

| Pattern | Meaning |
|---------|--------|
| **cmd \|\| true** | Run cmd; if it fails, do nothing (exit 0). |
| **if ! cmd; then ... fi** | If cmd fails, run the then block. |
| **cmd \|\| { echo "failed"; exit 1; }** | If cmd fails, print and exit. |

With **set -e**, a command that might fail can be wrapped so the script continues:

```bash
set -e
grep "pattern" file.txt || true   # script does not exit if no match
```

**Small examples:**

```bash
set -e
# Optional: create dir only if it doesn't exist
mkdir -p /tmp/myscript || true
# Required: this must succeed
touch /tmp/myscript/required.txt
```

```bash
if ! grep -q "success" log.txt; then
  echo "Pattern not found"
  exit 1
fi
```

---

## Recap: 1, 2, 3

- **1:** `set -euo pipefail` — exit on error, error on unset variable, pipeline fails if any part fails.
- **2:** Validate arguments and paths (e.g. `[ -f "$1" ]`) before use; use `${VAR:-default}` for optional vars.
- **3:** Use `|| true` to ignore a failure, or `if ! cmd` / `cmd || { ...; exit 1; }` to handle it.

---

## Example 1 — Focus on 1 (strict mode)

Write a short script that sets `set -euo pipefail`, then runs `echo "OK"`, then tries to `echo $UNDEFINED`. Run it and see the script stop at the unset variable. Remove the undefined line and run again.

---

## Example 2 — Focus on 2 (validation)

Write a script that expects one argument (a file path). If no argument is given, print usage and exit 1. If the argument is not a regular file, print an error and exit 1. Otherwise, run `wc -l` on the file.

---

## Example 3 — Focus on 3 (explicit handling)

Write a script with `set -e` that runs `grep "nonexistent" /etc/hostname || true`, then runs `echo "Done"`. Confirm the script reaches "Done" even though grep returns non-zero. Then change it to `grep "nonexistent" /etc/hostname` without `|| true` and see the script exit before "Done".

---

## Combined example — 1 + 2 + 3

Write a script **safe_wc.sh** that:

1. Uses `set -euo pipefail`.
2. Requires one argument; if missing, print usage and exit 1.
3. Checks that the argument is a regular file; if not, print an error and exit 1.
4. Runs `wc -l "$1"`. If you want to allow "no lines" without failing, use `wc -l "$1" || true` and then parse the output (or use a different approach so wc’s exit doesn’t matter).

You’ve combined strict mode, validation, and optional failure handling. Next: [02 - trap and signals](02-trap-and-signals.md).
