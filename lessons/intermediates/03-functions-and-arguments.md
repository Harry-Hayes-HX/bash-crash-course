# Lesson 3: Functions and Arguments

**Concepts:** **Script arguments** (`$1`, `$2`, `$@`, `$#`), **shift**, **defining and calling functions**.

---

## Concept 1: Script arguments — $1, $2, $#, $@

When you run **bash script.sh first second third**, the script receives **positional parameters**:

| Parameter | Meaning |
|-----------|--------|
| **$1** | First argument |
| **$2** | Second argument |
| **$9** | Ninth (later ones need braces: **${10}**) |
| **$#** | **C**ount of arguments |
| **$@** | All arguments as a list (each quoted); use in loops |
| **$0** | Name of the script (or shell) |

**Small examples:**

```bash
# Save as args.sh: echo "First: $1"; echo "Second: $2"; echo "Count: $#"
bash args.sh hello world
# First: hello, Second: world, Count: 2
```

```bash
# Loop over all arguments
for a in "$@"; do echo "Arg: $a"; done
```

```bash
# Check you have enough arguments
if [ $# -lt 1 ]; then echo "Usage: $0 <file>"; exit 1; fi
```

---

## Concept 2: shift

**shift** removes the first argument and “shifts” the rest: what was `$2` becomes `$1`, etc. Useful for processing arguments one by one in a loop.

```bash
while [ -n "$1" ]; do
  echo "Processing: $1"
  shift
done
```

**Small examples:**

```bash
# args_shift.sh: while [ -n "$1" ]; do echo "$1"; shift; done
# Run: bash args_shift.sh a b c
```

```bash
# Optional: shift 2 to drop two arguments at once
```

---

## Concept 3: Defining and calling functions

A **function** is a named block of commands. Define with **function name { ... }** or **name () { ... }**. Call with **name** or **name arg1 arg2** (arguments become $1, $2 inside the function; $0 and script args are unchanged).

```bash
myfunc() {
  echo "First arg to function: $1"
  echo "Second: $2"
}
myfunc "hello" "world"
```
*Output:*
```
First arg to function: hello
Second: world
```

**Small examples:**

```bash
greet() { echo "Hello, $1"; }
greet "Alice"
```
*Output:* `Hello, Alice`

```bash
# Function that uses a global or passed-in value
logdir() { echo "Logs in: ${1:-/var/log}"; }
logdir
logdir ~/bash-practice/logs
```
*Note: ${1:-/var/log} = use $1 if set, else /var/log.*

*Output:*
```
Logs in: /var/log
Logs in: /home/you/bash-practice/logs
```


```bash
# Return a value via echo (Bash has no real “return value” for strings)
get_date() { date +%Y-%m-%d; }
TODAY=$(get_date)
echo "Today: $TODAY"
```
*Output:* `Today: 2025-02-05` *(or whatever date you run it)*

---

## Recap: 1, 2, 3

- **1:** `$1`, `$2`, `$#`, `$@` — script arguments; check `$#` before using `$1`.
- **2:** `shift` — drop first argument and renumber the rest; use in while loops.
- **3:** `name() { ... }` — define; `name arg1 arg2` — call; function has its own `$1`, `$2`.

---

## Example 1 — Focus on 1 (arguments)

Write a script that prints: “You passed N arguments. First: &lt;first&gt;, Last: &lt;last&gt;.” Use `$#`, `$1`, and for “last” use a loop over `$@` or `${@: -1}` (last element in Bash) or a variable you set in a loop.

---

## Example 2 — Focus on 2 (shift)

Write a script that uses **while [ -n "$1" ]** and **shift**: in each iteration print “Remaining: $# — current: $1”, then shift. Run with three arguments and watch the count and current value change.

---

## Example 3 — Focus on 3 (functions)

Define a function **abspath** that echoes “Path: $1” (or the real path with `realpath "$1"` if available). Call it with two different paths. Then define **usage** that echoes “Usage: $0 &lt;file&gt;” and call **usage** from the script.

---

## Combined example — 1 + 2 + 3

Write a script **run_cat.sh** that:

1. Defines a function **do_cat** that: if `$1` is empty, prints “No file given” and returns 1; else runs **cat "$1"** and returns 0 (or use the exit code of cat).
2. If the script has no arguments, prints “Usage: $0 &lt;file&gt; [file ...]” and exits 1.
3. Uses a **while [ -n "$1" ]** loop: call **do_cat "$1"**, then **shift**. (So: `bash run_cat.sh f1.txt f2.txt` cats each file.)

You’ve used arguments, shift, and a function. Next: [04 - Exit codes and robustness](04-exit-codes-and-robustness.md).
