# Lesson 3: Arrays and Structured Data

**Concepts:** **Bash arrays** (indexed), **"${arr[@]}"** and **"${!arr[@]}"**, **mapfile** / **readarray** (lines into array).

---

## Concept 1: Arrays — create and use

An **array** holds multiple values. Create with **arr=(value1 value2 value3)**. Use **"${arr[@]}"** to expand all elements (each quoted); **"${arr[i]}"** for one element (0-based); **"${#arr[@]}"** for the count.

**Small examples:**

```bash
files=(app.log system.log backup.log)
echo "${files[1]}"
echo "${#files[@]}"
for f in "${files[@]}"; do echo "$f"; done
```

```bash
# Append
arr=(a b)
arr+=(c d)
echo "${arr[@]}"
```

```bash
# From command output (words)
dirs=($(ls -d /etc/*/ 2>/dev/null | head -3))
echo "${dirs[@]}"
```

---

## Concept 2: Indices and "${!arr[@]}"

**"${!arr[@]}"** expands to the **indices** of the array (0, 1, 2, …). Use it to iterate by index or to handle sparse arrays.

**Small examples:**

```bash
arr=(first second third)
for i in "${!arr[@]}"; do
  echo "Index $i: ${arr[$i]}"
done
```

**Note:** `${!arr[@]}` is **Bash** syntax. If your shell is **zsh** (default on many Macs), `!` is used for history expansion and you’ll see something like `zsh: event not found`. Run the code in Bash instead: type **bash** and press Enter, then run the lines, or save them to a file and run **bash script.sh**.

```bash
# Check if index exists (sparse array)
declare -a a
a[0]=zero
a[2]=two
for i in "${!a[@]}"; do echo "$i => ${a[$i]}"; done
```

---

## Concept 3: mapfile / readarray

**mapfile** (or **readarray**) reads lines from stdin into an array—one line per element. Handy for lists of paths or config lines. These are **Bash** builtins; they don’t exist in zsh, so run the examples below in **bash** (e.g. type **bash** then run the commands, or use a script with `#!/bin/bash`).

| Syntax | Effect |
|--------|--------|
| **mapfile -t arr** | Read stdin into **arr**; **-t** strips newlines. |
| **mapfile -t arr < file** | Read **file** into **arr**. |
| **readarray -t arr < <(command)** | Read output of **command** into **arr**. |

**Small examples:**

```bash
mapfile -t lines < /etc/hostname
echo "${lines[0]}"
```

```bash
mapfile -t dirs < <(find /tmp -maxdepth 1 -type d 2>/dev/null)
echo "Found ${#dirs[@]} dirs"
printf '%s\n' "${dirs[@]}"
```

```bash
# Process file line by line via array
mapfile -t arr < config.txt
for line in "${arr[@]}"; do
  [[ "$line" =~ ^# ]] && continue
  echo "Line: $line"
done
```

**Alternative when mapfile isn't available (Bash 3.2, e.g. default macOS):** You can fill an array from a file with a loop. Use **arr=()** then **while IFS= read -r line; do arr+=( "$line" ); done < file**. Same idea as mapfile—one line per element.

```bash
paths=()
while IFS= read -r line; do paths+=( "$line" ); done < "$DIR/files.txt"
# Now paths is an array of lines, same as with mapfile -t paths < "$DIR/files.txt"
```

---

## Recap: 1, 2, 3

- **1:** **arr=(a b c)**, **"${arr[@]}"**, **"${arr[i]}"**, **"${#arr[@]}"** — create, expand all, one element, length.
- **2:** **"${!arr[@]}"** — list of indices; use in loops when you need the index.
- **3:** **mapfile -t arr < file** or **< <(cmd)** — fill array from lines. On Bash 3.2 (e.g. macOS): **arr=(); while IFS= read -r line; do arr+=( "$line" ); done < file**.

---

## Example 1 — Focus on 1 (arrays)

Create an array of three log filenames. Loop over **"${arr[@]}"** and print each name and a placeholder "would process". Then print the number of elements with **"${#arr[@]}"**.

---

## Example 2 — Focus on 2 (indices)

Create an array **arr=(alpha beta gamma)**. Loop with **for i in "${!arr[@]}"; do** and print "Index i is arr[i]".

---

## Example 3 — Focus on 3 (mapfile)

Create a file with three lines (e.g. path1, path2, path3). Use **mapfile -t paths < thatfile**. Print the number of lines and then each element of **paths**.

---

## Combined example — 1 + 2 + 3

Write a script that:

1. Uses **mapfile -t** to read the output of **find . -maxdepth 1 -type f -name "*.txt"** into an array **files**.
2. If **"${#files[@]}"** is 0, print "No .txt files" and exit 0.
3. Loop over **"${!files[@]}"** and for each index **i** print "**i**: **files[i]**".

You’ve used mapfile, array length and indices. Next: [04 - getopts and options](04-getopts-and-options.md).
