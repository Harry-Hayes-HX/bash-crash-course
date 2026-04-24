# Module 2: Files and Basics

**Concepts:** **Viewing files** (cat, head, tail), **creating folders and files** (mkdir, touch), **copy, move, delete** (cp, mv, rm).

---

## Concept 1: Viewing file contents

You often need to *look* at a file without opening it in an editor—e.g. a config or log.

| Command | What it does |
|---------|----------------|
| **cat** *filename* | Show the **entire** file on screen |
| **head** *filename* | Show the **first** 10 lines |
| **tail** *filename* | Show the **last** 10 lines |
| **head -n 5** *file* | First 5 lines (`-n` = number) |
| **tail -n 20** *file* | Last 20 lines |

**Small examples:**

<img src="/static/images/lessons/basics/02-files-and-basics/02-catting-a-file.png" alt="Screenshot: running cat" style="max-width: 780px; height: auto;" />

*Example: terminal with cat command example. If the file exists, you’ll see its full contents. (If “No such file”, that’s OK, it just means the file doesnt exist, or you made a typo)*

<img src="/static/images/lessons/basics/02-files-and-basics/02-heading-a-file.png" alt="Screenshot: running head -n 10" style="max-width: 780px; height: auto;" />

*Example: terminal with head -n 10 command example. Only prints the first 10 lines.*

<img src="/static/images/lessons/basics/02-files-and-basics/02-tailing-a-file.png" alt="Screenshot: running tail -n 10" style="max-width: 780px; height: auto;" />

*Example: terminal with tail -n 10 command example. Only prints the last 10 lines.*

---

## Concept 2: Creating folders and files

| Command | What it does |
|---------|----------------|
| **mkdir** *foldername* | **m**a**k**e a new **dir**ectory |
| **touch** *filename* | Create an empty file (or update its “modified” time if it exists) |

**Small examples:**

<img src="/static/images/lessons/basics/02-files-and-basics/mkdir.png" alt="Screenshot: running mkdir {foldername}" style="max-width: 780px; height: auto;" />

*Example: terminal with mkdir command*

<img src="/static/images/lessons/basics/02-files-and-basics/touch-new.png" alt="Screenshot: running touch to make a new file" style="max-width: 780px; height: auto;" />
<img src="/static/images/lessons/basics/02-files-and-basics/touch-new-time.png" alt="Screenshot: time i ran touch to make a new file" style="max-width: 780px; height: auto;" />

*Example: terminal with touch command in empty directory*


<img src="/static/images/lessons/basics/02-files-and-basics/touch-update.png" alt="Screenshot: running touch to update the modified time attribute of a file" style="max-width: 780px; height: auto;" />

<img src="/static/images/lessons/basics/02-files-and-basics/touch-update-time.png" alt="Screenshot: time i ran touch to update the modified time attribute of a file" style="max-width: 780px; height: auto;" />

*Example: terminal with touch command on existing file*

<img src="/static/images/lessons/basics/02-files-and-basics/touch-multiple-new.png" alt="Screenshot: running touch with multiple files as arguments" style="max-width: 780px; height: auto;" />

*Example: terminal with touch command on existing file*



---

## Concept 3: Copy, move, and delete

| Command | What it does |
|---------|----------------|
| **cp** *source* *destination* | **c**o**p**y a file (original stays) |
| **mv** *source* *destination* | **m**o**v**e (or rename) a file |
| **rm** *filename* | **r**e**m**ove (delete) a file |
| **rm -r** *foldername* | **r**e**m**ove **-r**ecursive - Remove a folder and everything inside it |

**Small examples:**

<img src="/static/images/lessons/basics/02-files-and-basics/cp-example.png" alt="Screenshot: Running copy command" style="max-width: 780px; height: auto;" />

*Example: terminal with copy command*

<img src="/static/images/lessons/basics/02-files-and-basics/mv-example.png" alt="Screenshot: Running move command" style="max-width: 780px; height: auto;" />

*Example: terminal with move command*

<img src="/static/images/lessons/basics/02-files-and-basics/mv-example-rename.png" alt="Screenshot: Running move command" style="max-width: 780px; height: auto;" />

*Example: terminal with move command used to rename file*

<img src="/static/images/lessons/basics/02-files-and-basics/rm-example.png" alt="Screenshot: Running remove command" style="max-width: 780px; height: auto;" />

*Example: terminal with remove command*

<img src="/static/images/lessons/basics/02-files-and-basics/rm-r-example.png" alt="Screenshot: Running recursive remove command" style="max-width: 780px; height: auto;" />

*Example: terminal with remove recursive command*

---

## Recap:

- **1:** `cat` / `head` / `tail` = view file contents (full, start, or end).
- **2:** `mkdir` = new folder; `touch` = new empty file.
- **3:** `cp` = copy; `mv` = move/rename; `rm` = delete (use with care).

---

## Example 1 — Focus on viewing files

1. Go to a folder that has a text file (e.g. `cd ~/bash-practice` and create one with `touch test.txt` then add a line: `echo "Line 1" > test.txt` and `echo "Line 2" >> test.txt`).
2. Run `cat test.txt` — see both lines.
3. Run `head -n 1 test.txt` — see only the first line.
4. Run `tail -n 1 test.txt` — see only the last line.

---

## Example 2 — Focus on creating folders and files

1. In your home directory run: `mkdir helpdesk-labs`.
2. `cd helpdesk-labs`.
3. Create three files: `touch ticket-001.txt ticket-002.txt ticket-003.txt`.
4. Run `ls` and confirm all three files and the folder exist.

---

## Example 3 — Focus on copy, move, delete

1. In `helpdesk-labs`: `cp ticket-001.txt ticket-001-copy.txt` then `ls`.
2. Rename the copy: `mv ticket-001-copy.txt backup-001.txt` then `ls`.
3. Remove only the backup: `rm backup-001.txt` then `ls` — backup is gone, original remains.

---

## Combined example:

**Goal:** Create a small “log” folder, add a fake log file, view it, make a backup, then clean up one file.

1. From home: `mkdir ~/bash-practice/logs` (or stay in `helpdesk-labs` and run `mkdir logs`) then `cd logs`.
2. Create a log file and put two lines in it:
   ```bash
   echo "2024-01-15 10:00 User login" > app.log
   echo "2024-01-15 10:05 User logout" >> app.log
   ```
3. **View it:** `cat app.log`, then `tail -n 1 app.log` (most recent “event”).
4. **Copy it:** `cp app.log app.log.backup` then `ls`.
5. **Rename the backup:** `mv app.log.backup app-20240115.backup` then `ls`.
6. **Remove the backup:** `rm app.log` then `ls` — only `app-20240115.backup` remains.

You’ve used viewing files, creating files/folders, and copying/moving/deleting files/folders. From here on out, you are not allowed to use your Finder application untill the end of the workshop. if you want to view a file, you will need to cd to its directory, and use cat to print its contents to the terminal. Next: finding and filtering (Module 3).

You’ve completed the files and basics, now move onto: [03 - Finding and Filtering](03-finding-and-filtering.md).

---

