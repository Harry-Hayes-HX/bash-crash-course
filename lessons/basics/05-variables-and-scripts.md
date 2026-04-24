# Module 5: Variables and Simple Scripts

**Concepts:** **Variables** (storing a value in a name), **echo** (printing and debugging), **running a simple script** (reusing commands safely), **export** (making variables visible to scripts).

---

## Concept 1: Variables — storing a value

In the shell you can store text or numbers in **variables** so you don’t have to retype them.

- **Set:** `NAME=value` (no spaces around `=`)
- **Use:** `$NAME` — the shell replaces `$NAME` with the value

**Small examples:**

<img src="/static/images/lessons/basics/05-variables-and-scripts/variable-example-1.png" alt="Screenshot: variable example 1" style="max-width: 780px; height: auto;" />

*Prints: Help Desk*


<img src="/static/images/lessons/basics/05-variables-and-scripts/variable-example-2.png" alt="Screenshot: variable example 2" style="max-width: 780px; height: auto;" />

*Same as `ls ~/bash-practice` — useful when the path is long.*


<img src="/static/images/lessons/basics/05-variables-and-scripts/variable-example-3.png" alt="Screenshot: variable example 3" style="max-width: 780px; height: auto;" />

*assigns the command `date +%Y-%m-%d` to `TODAY`. Then `echo $TODAY` runs the date command and uses its output as the value.*

---

## Concept 2: `echo` — printing and checking

**echo** just prints whatever you give it. Use it to show messages or to **debug** (see what a variable or command produces).

| Usage | What it does |
|-------|----------------|
| **echo "Hello"** | Prints Hello |
| **echo $VAR** | Prints the value of VAR |
| **echo "Value is $VAR"** | Prints a line mixing text and variable |
| **echo "OVERWRITE" > file.txt** | **Overwrites** a file (Deletes existing contents and writes new contents)|
| **echo "APPEND" >> file.txt** | **Appends** a line to a file (Adds the new content on the next line after the original content - you saw this in Module 2) |

**Small examples:**


<img src="/static/images/lessons/basics/05-variables-and-scripts/echo-example-1.png" alt="Screenshot: echo example 1" style="max-width: 780px; height: auto;" />

*Simple “status” lines — handy at the start of a script.*


<img src="/static/images/lessons/basics/05-variables-and-scripts/echo-example-2.png" alt="Screenshot: echo example 2" style="max-width: 780px; height: auto;" />

*Append a timestamp line to a log file, then view it.*

---

## Concept 3: A simple script (saving and running commands)

A **script** is a text file full of commands. The shell runs them one after another. Benefits: repeat the same steps without retyping; share with colleagues; avoid dangerous copy-paste mistakes.

- **Create:** Use any text editor; save as something like `myscript.sh`.
- **Run:** `bash myscript.sh` (no need to make it “executable” yet) or `./myscript.sh` after `chmod +x myscript.sh`.
- **First line (optional):** `#!/bin/bash` — tells the system to use Bash to run the file.

**Small example — create this file** (e.g. `~/bash-practice/hello.sh`):

<img src="/static/images/lessons/basics/05-variables-and-scripts/script-example-1.png" alt="Screenshot: echo example 2" style="max-width: 780px; height: auto;" />

You should see the three lines printed. That’s a script using **variables**, **echo**, and **running a script**.

---

## Concept 4: `export` — making variables visible to scripts

When you set a variable in the shell (`VAR=value`), it exists only in that shell. A **script** you run (e.g. `./myscript.sh`) is a **child process** and does not see your variables unless you either pass them for that one command or **export** them.

| Approach | What it does |
|----------|----------------|
| `VAR=value ./script.sh` | Sets `VAR` only for that single run of `script.sh`. The script sees `$VAR`. |
| `export VAR=value` then `./script.sh` | Puts `VAR` into the **environment** so every command you run from that shell (including `./script.sh`) sees it. |

Use **export** when you want a variable to be available to the script (and any other commands you run after). You can write `export VAR=value` or set first and then `export VAR`.

**Small example:** `export MY_NAME=Alice` then run a script that does `echo "Hello, $MY_NAME"` — the script will print `Hello, Alice` because `MY_NAME` was exported.

---

## Recap:

- **1:** `VAR=value` to set; `$VAR` to use; `VAR=$(command)` to store command output.
- **2:** `echo` prints text and variable values; `echo "..." >> file` appends to a file.
- **3:** Put commands in a `.sh` file and run with `bash script.sh` (or `./script.sh` after chmod +x).
- **4:** `export VAR=value` (or `export VAR` after setting) makes the variable visible to scripts and other child processes; or use `VAR=value ./script.sh` for a single run.

---

## Example 1 — Focus on variables

1. Set `REPORT=~/bash-practice/report.txt` and run `ls $REPORT` (create the file with `touch $REPORT` if needed).
2. Set `COUNT=5` and run `echo "I have $COUNT items"`.
3. Set `NOW=$(date)` and run `echo $NOW`. You’ve stored and used variables.

---

## Example 2 — Focus on `echo`

1. Run `echo "Help desk check"` and `echo "User: $(whoami)"`.
2. Run `echo "Step 1 done at $(date)" >> ~/bash-practice/run.log` then `echo "Step 2 done at $(date)" >> ~/bash-practice/run.log` and finally `cat ~/bash-practice/run.log`.
3. Run `echo "Step 1 redone at $(date)" > ~/bash-practice/run.log` then `cat ~/bash-practice/run.log`.
4. Use echo to debug: set `DIR=~/bash-practice` and run `echo "Looking in $DIR"` then `ls $DIR`.

---

## Example 3 — Focus on scripts

1. Create `~/bash-practice/status.sh` with:
   ```bash
   #!/bin/bash
   echo "=== System status ==="
   echo "User: $(whoami)"
   echo "Date: $(date)"
   echo "Directory: $(pwd)"
   ```
2. Run `bash ~/bash-practice/status.sh`.
3. Optionally: `chmod +x ~/bash-practice/status.sh` then run `bash ~/bash-practice/status.sh` (or `./status.sh` from that directory).

---

## Combined example:

**Goal:** A small script that uses a variable for a folder, echoes what it’s doing, and writes a one-line “report” to a file.

1. Create `~/bash-practice/quick-report.sh`:

```bash
#!/bin/bash
# Quick report script — uses variables, echo, and scripting
REPORTDIR=~/bash-practice
REPORTFILE=$REPORTDIR/report-$(date +%Y%m%d).txt

echo "Report directory: $REPORTDIR"
echo "Report file: $REPORTFILE"
echo "Writing report at $(date)" > "$REPORTFILE"
echo "User: $(whoami)" >> "$REPORTFILE"
echo "Done. Contents of report:"
cat "$REPORTFILE"
```

2. Run it: `bash ~/bash-practice/quick-report.sh`.
3. You should see echoed messages, variables like `$REPORTDIR` and `$REPORTFILE`, and a script that creates/updates a dated report file. Check with `ls ~/bash-practice/report-*.txt` and `cat` one of them.

You’ve combined variables, echo, and a runnable script. Next: the full help desk scenario (Module 6).

You’ve completed Variables and Scripts, now move onto: [06 Help Desk Scenario](06-help-desk-scenario.md).

---