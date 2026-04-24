# Module 3: Finding and Filtering

**Concepts:** **find** (locate files by name or type), **grep** (search text inside files), **pipes** (chain commands together).

---

## Concept 1: Finding files with `find`

When you don’t know where a file is, **find** searches from a folder downward.

| Command | What it does |
|---------|----------------|
| **find** *folder* **-name** *"pattern"* | Find files/folders whose name matches |
| **find** *folder* **-type f** | Only files |
| **find** *folder* **-type d** | Only directories |
| **find . -name "*.log"** | Find all `.log` files from current directory (`.` = here) |

The `*` is a wildcard: “anything”. So `*.log` = “anything ending in .log”.

**Small examples:**

<img src="/static/images/lessons/basics/03-finding-and-filtering/find-txt-files.png" alt="Screenshot: Running find . -name '*.txt' -type f" style="max-width: 780px; height: auto;" />

*Lists all `.txt` files under your home directory. (Might be a long list.)*


<img src="/static/images/lessons/basics/03-finding-and-filtering/find-logs-files.png" alt="Screenshot: Running find . -name '*.log'" style="max-width: 780px; height: auto;" />

*Finds any file ending in `.log` under `bash-practice`.*


<img src="/static/images/lessons/basics/03-finding-and-filtering/find-logs-directory.png" alt="Screenshot: Running find . -type d -name 'logs'" style="max-width: 780px; height: auto;" />

*Finds directories named exactly `logs`.*

---

## Concept 2: Searching inside files with `grep`

**grep** looks for a **text pattern** inside files (e.g. an error code or username in a log).

| Command | What it does |
|---------|----------------|
| **grep** *"text"* *filename* | Show lines that contain *text* |
| **grep -i** *"text"* *file* | Same, but **i**gnore case (e.g. "error" matches "Error") |
| **grep -n** *"text"* *file* | Show **n**umbered lines (handy for “line 42”) |
| **grep -c** *"text"* *file* | **C**ount how many lines match |

**Small examples:**


<img src="/static/images/lessons/basics/03-finding-and-filtering/grep-for-error.png" alt="Screenshot: Running grep 'ERROR' sample.log" style="max-width: 780px; height: auto;" />

*Only the lines containing “ERROR” are printed.*


<img src="/static/images/lessons/basics/03-finding-and-filtering/grep-for-error-line-number.png" alt="Screenshot: Running grep 'ERROR' sample.log with the line numbers" style="max-width: 780px; height: auto;" />

*Same lines, with line numbers.*


<img src="/static/images/lessons/basics/03-finding-and-filtering/grep-for-error-case-insensitive.png" alt="Screenshot: Running grep 'ERROR' sample.log with the line numbers" style="max-width: 780px; height: auto;" />

*Matches “error”, “Error”, “ERROR”, etc.*

---

## Concept 3: Pipes — connecting commands

A **pipe** is the `|` character. It sends the **output** of one command as the **input** of the next.

- **Command1 | Command2** = “Run Command1, then feed its output to Command2.”

Common use: list or find something, then filter with `grep`.

| Example | What it does |
|---------|----------------|
| **ls \| grep .txt** | List files, show only lines that contain “.txt” |
| **cat file \| grep "error"** | Show only lines of `file` that contain “error” |
| **find . -name "*.log" \| head -n 5** | Find `.log` files, show only the first 5 results |

**Small examples:**


<img src="/static/images/lessons/basics/03-finding-and-filtering/pipe-example-1.png" alt="Screenshot: Running ls -la . | grep 'error'" style="max-width: 780px; height: auto;" />

*List current directory in long form; show only lines that contain “error”*


<img src="/static/images/lessons/basics/03-finding-and-filtering/pipe-example-2.png" alt="Screenshot: Running cat sample.log | grep -i 'error'" style="max-width: 780px; height: auto;" />

*Same as `grep -i error` on that file—but shows the idea of piping.*


<img src="/static/images/lessons/basics/03-finding-and-filtering/pipe-example-3.png" alt="Screenshot: Running find . -type f | head -n 3" style="max-width: 780px; height: auto;" />

*Find all files in `current directory`, then show only the first 3 paths.*

---

## Recap:

- **1:** `find folder -name "pattern"` = find files/folders by name; `-type f` = files only.
- **2:** `grep "text" file` = lines containing that text; `-i` = ignore case, `-n` = line numbers.
- **3:** `|` = pipe: output of left command becomes input of right command.

---

## Example 1 — Focus on `find`

1. `cd ~/bash-practice` (or a folder you created earlier).
2. Create a few files: `touch report.txt notes.txt report-backup.txt`.
3. Run: `find . -name "*.txt"`.
4. Run: `find . -name "report*"` — only names starting with “report”.
5. Run: `find . -type f` — list all files (no folders).

---

## Example 2 — Focus on `grep`

1. Create a small log:  
   `echo "User alice login
   User bob login
   User alice logout
   FAIL alice" > ~/bash-practice/auth.log`
2. Run: `grep "alice" ~/bash-practice/auth.log`.
3. Run: `grep -n "FAIL" ~/bash-practice/auth.log`.
4. Run: `grep -c "login" ~/bash-practice/auth.log` — count of “login” lines.

---

## Example 3 — Focus on `|`

1. Run: `ls ~ | grep -i doc` — list home, show only lines containing “doc” (e.g. Documents).
2. Run: `cat ~/bash-practice/auth.log | grep "bob"`.
3. Run: `find ~/bash-practice -type f | wc -l` — number of files (`wc -l` = count lines).

---

## Combined example:

**Goal:** Find all `.log` files under a folder, search inside them for “ERROR”, and show the first 5 matching lines with line numbers.

1. Ensure you have a log with “ERROR” in it, e.g. in `~/bash-practice`:  
   `echo "ERROR: something broke" >> sample.log`
2. **Find** all log files:  
   `find ~/bash-practice -name "*.log" -type f`
3. **Search** inside one of them and show line numbers:  
   `grep -n "ERROR" ~/bash-practice/sample.log`
4. **Pipe** file content into grep and limit output:  
   `cat ~/bash-practice/sample.log | grep -n "ERROR" | head -n 5`

If you have multiple logs, you can run:  
`find ~/bash-practice -name "*.log" -exec grep -n "ERROR" {} \;`  
(or use a simple loop later). For now, the pipe from `cat` to `grep` to `head` shows **find**, **grep**, and **pipes** working together. Next: permissions and users (Module 4).

You’ve completed Finding and Filtering, now move onto: [04 - Permissions and Users ](04-permissions-and-users.md).

---