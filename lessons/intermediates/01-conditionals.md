# Lesson 1: Conditionals

**Concepts:** **if / then / else**, **test** and **\[ \]** (conditions), **file and string checks** (`-f`, `-d`, `-z`).

---

## Concept 1: if, then, else, fi

Scripts often need to **branch**: do one thing if a condition is true, something else if not. In Bash you use **if**, **then**, **else**, and **fi** (if backwards = end of block).

```bash
if condition; then
  commands when true
else
  commands when false
fi
```

The **condition** is usually a command or `test` (see below). If it exits with 0, the “then” branch runs; otherwise the “else” branch runs.

**Small examples:**

```bash
if true; then echo "Yes"; else echo "No"; fi
```
*Prints: Yes*

```bash
if false; then echo "Yes"; else echo "No"; fi
```
*Prints: No*

```bash
if [ 1 -eq 1 ]; then echo "Equal"; fi
```
*Prints: Equal (no else needed).*

---

## Concept 2: test and [ ]

**test** checks conditions (files, numbers, strings). The same checks are often written as **\[ condition \]** (note spaces inside the brackets).

| Check | Meaning |
|-------|--------|
| **\[ -f path \]** | Path exists and is a **f**ile |
| **\[ -d path \]** | Path exists and is a **d**irectory |
| **\[ -e path \]** | Path **e**xists (file or dir) |
| **\[ -z "string" \]** | String has **z**ero length (empty) |
| **\[ -n "string" \]** | String is **n**on-empty |
| **\[ "$a" = "$b" \]** | Strings equal |
| **\[ "$a" != "$b" \]** | Strings not equal |
| **\[ 1 -eq 2 \]** | Numbers **eq**ual |
| **\[ 1 -lt 2 \]** | Less **t**han; **-le** ≤, **-gt** >, **-ge** ≥ |

**Small examples:**

```bash
[ -f /etc/hostname ] && echo "File exists" || echo "No file"
```
*Short form: command1 && command2 (run 2 if 1 succeeds); command1 || command2 (run 2 if 1 fails).*

```bash
if [ -d "$HOME" ]; then echo "Home is a directory"; fi
```

```bash
NAME=""
if [ -z "$NAME" ]; then echo "NAME is empty"; fi
```

---

## Concept 3: Using conditionals with files and strings

Combine **if** with **test** to react to the real state of the system: “if this file exists”, “if this directory is writable”, “if the user gave an argument”.

**Small examples:**

```bash
# In a script: check if first argument is a file
if [ -f "$1" ]; then
  echo "$1 is a file"
else
  echo "$1 is not a file or missing"
fi
```
*Save as check.sh, run: `bash check.sh /etc/hostname` then `bash check.sh /nonexistent`.*

```bash
# Check if a dir exists before cd
TARGET=~/bash-practice
if [ -d "$TARGET" ]; then
  cd "$TARGET" && pwd
else
  echo "Directory $TARGET not found"
fi
```

```bash
# Compare two strings
READ="yes"
if [ "$READ" = "yes" ]; then echo "Proceeding"; fi
```

---

## Recap: 1, 2, 3

- **1:** `if condition; then ... else ... fi` — branch on success/failure of the condition.
- **2:** `test` / `[ ]` — `-f` file, `-d` dir, `-z` empty string, `=`, `-eq`, etc.
- **3:** Use these in scripts to check files, dirs, and arguments before acting.

---

## Example 1 — Focus on 1 (if/else)

Write a one-liner that prints “OK” if `$HOME` is a directory, else “Not a dir”. Use `if [ -d "$HOME" ]; then ... else ... fi`.

---

## Example 2 — Focus on 2 (test / [ ])

1. Create a file: `touch ~/bash-practice/cond.txt`.
2. Run: `[ -f ~/bash-practice/cond.txt ] && echo "file" || echo "no"`.
3. Run: `[ -d ~/bash-practice/cond.txt ] && echo "dir" || echo "no"`.
4. Try with a missing path and see “no”.

---

## Example 3 — Focus on 3 (file check in a script)

Create a script that takes one argument (a path). If it’s a file, print “File:” and the path. If it’s a directory, print “Dir:” and the path. Otherwise print “Missing or other.” Use `if [ -f "$1" ]; then ... elif [ -d "$1" ]; then ... else ... fi`.

---

## Combined example — 1 + 2 + 3

Write a script **safecat.sh** that:

1. Takes one argument (a path).
2. If the argument is empty, print “Usage: bash safecat.sh <path>” and exit with 1.
3. If the path is not a regular file, print “Not a file: &lt;path&gt;” and exit with 1.
4. Otherwise run `cat` on the path.

Use **if**, **\[ -z "$1" \]**, **\[ -f "$1" \]**, and **exit 1** / **exit 0**. Run it with no args, with a directory, and with a real file.

You’ve used conditionals, test, and file checks in one script. Next: [02 - Loops](02-loops.md).
