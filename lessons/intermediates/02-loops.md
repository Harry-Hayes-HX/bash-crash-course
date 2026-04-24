# Lesson 2: Loops

**Concepts:** **for** (over a list or files), **for** with ranges, **while** (repeat until a condition fails).

---

## Concept 1: for over a list

A **for** loop runs one or more commands once for each item in a list.

```bash
for item in item1 item2 item3; do
  echo "Processing $item"
done
```

The list can be literal words, variables, or the output of a command (e.g. `$(ls *.txt)`).

**Small examples:**

```bash
for name in alice bob carol; do echo "User: $name"; done
```

```bash
for f in file1.txt file2.txt; do touch "$f"; done
ls file*.txt
```

```bash
# Loop over output of a command (one word per line)
for dir in /bin /usr/bin; do echo "Dir: $dir"; ls "$dir" | head -1; done
```

---

## Concept 2: for over files and ranges

- **Loop over files:** use a glob so the shell expands it to a list of pathnames.
- **Loop over numbers:** use **{1..5}** (Bash) or **$(seq 1 5)** for portability.

**Small examples:**

```bash
# Over files matching a pattern (create a few first: touch a.txt b.txt c.txt)
for f in *.txt; do echo "File: $f"; done
```

```bash
# Number range (Bash)
for i in {1..5}; do echo "Count $i"; done
```

```bash
# seq for portability
for i in $(seq 1 3); do echo "Step $i"; done
```

```bash
# Process each .log file in a directory
mkdir -p ~/bash-practice/logs2
touch ~/bash-practice/logs2/{a,b,c}.log
for log in ~/bash-practice/logs2/*.log; do echo "--- $log ---"; head -1 "$log" 2>/dev/null || echo "(empty)"; done
```

---

## Concept 3: while loops

**while** runs the body as long as the condition (command or `test`) succeeds (exit 0).

```bash
while condition; do
  commands
done
```

Use **while** when you don’t have a fixed list (e.g. “until user quits” or “until a file appears”). Be careful not to create an infinite loop.

**Small examples:**

```bash
# Count down (Bash)
n=3
while [ "$n" -gt 0 ]; do echo "n=$n"; n=$((n-1)); done
```

```bash
# Read lines from a file (safe pattern)
while IFS= read -r line; do echo "Line: $line"; done < ~/.bashrc
```
*Stops when there are no more lines.*

```bash
# Process arguments until none left (see Lesson 3 for shift)
# set -- one two three
# while [ -n "$1" ]; do echo "Arg: $1"; shift; done
```

---

## Recap: 1, 2, 3

- **1:** `for item in list; do ... done` — repeat for each item.
- **2:** Use globs (`*.txt`) or `{1..5}` / `$(seq 1 5)` for files or numbers.
- **3:** `while condition; do ... done` — repeat while condition is true.

---

## Example 1 — Focus on 1 (for over list)

Write a loop that prints “Hello {colour}” once for each of: red, green, blue. Then a loop that runs `echo "Checking $d"` for each of `/etc`, `/tmp`, `$HOME`.

---

## Example 2 — Focus on 2 (files and ranges)

1. In `~/bash-practice`, create five files: `report_1.txt` … `report_5.txt` (use a loop with `{1..5}` and `touch`).
2. Loop over `report_*.txt` and print each filename and its line count: `wc -l < "$f"` (or `wc -l "$f"`).

---

## Example 3 — Focus on 3 (while)

Write a script that sets `count=0`, then runs a **while** loop: while `count` is less than 3, print “Count: $count” and add 1 to count. Use `[ "$count" -lt 3 ]` and `count=$((count+1))`.

---

## Combined example — 1 + 2 + 3

Write a script **batch_echo.sh** that:

1. Takes two arguments: a **directory** and a **suffix** (e.g. `.log`).
2. If the directory doesn’t exist or isn’t a directory, print an error and exit 1.
3. Uses a **for** loop over `"$1"/*"$2"` (files in that dir with that suffix).
4. For each file, prints the filename and the **first line** of the file (with `head -n 1`).

Use **\[ -d "$1" \]**, **for f in ...**, and **head -n 1 "$f"**. Optionally add a **while** that reads a list of directories from stdin and runs the same logic for each (advanced).

You’ve used **for** over a list/files (1, 2) and can extend with **while** (3). Next: [03 - Functions and arguments](03-functions-and-arguments.md).
