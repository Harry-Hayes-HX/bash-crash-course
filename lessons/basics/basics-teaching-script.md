# Bash Crash Course — Basics Teaching Script


**Cues in the script:**
- **[DEMO]** — Run this in the terminal so learners see it.
- **[PAUSE]** — Give learners a moment to try it themselves or ask questions.
- **[ASK]** — Optional question to pose to the room.
- **[RECAP]** — Short summary to say out loud before moving on.
- **[SETUP]** — Do this before learners arrive or during a break (e.g. Module 6).

---

## Before you start

- **Have a terminal open** and a practice folder (e.g. `~/bash-practice`) ready, or create it when you reach Module 2.
- **Share the lesson link** (REFEREE-SITE or the rendered basics lessons) so learners can follow along or review.
- **Rough timing:** History ~5 min, Getting Started ~15 min, Files ~15 min, Finding/Filtering ~15 min, Permissions ~15 min, Variables/Scripts ~20 min, Help Desk Scenario ~25 min. Adjust for your audience and pace.

---

# Module 0: History of Bash (~5 min)

**Goal:** Give context so “Bash” and “shell” aren’t black boxes. Keep it short.

**Say something like:**

> “Before we type a single command, a quick bit of context. I personally learn best when i find something interesting, and the history of bash is very interesting, so im going to give you a quick rundown of that history. In the late 1960s and early 1970s, Unix was developed at Bell Labs. Unix is a family of multitasking, multi-user operating systems. Users needed a way to type commands and run programs. That program, called the shell, read your input and started other programs.
>
> The first Unix shell was the Thompson shell in 1971, which was very basic. Then in 1977, a man named Stephen Bourne wrote the Bourne shell, or **sh** for short. It had variables, control flow, and could run scripts, and it ended up becoming the standard. Many systems still have a command called **sh** that is either that shell or another compatible shell.
>
> **Bash** stands for **B**ourne **A**gain **SH**ell. It was written for the GNU Project in 1989 by Brian Fox. The idea was a free, feature-rich shell that behaved like the Bourne shell but added better interactivity and scripting—command history, editing and arrays to name a few. Bash became the default shell on most Linux distributions and on macOS for a long time. When people say ‘shell script’ on Linux, they usually mean Bash.
>
> Why does this matter for you? Bash, or something very like it, is on almost every Linux server, most Macs, and in tools like Git Bash on Windows. Scripts you write can run in a lot of places. Servers, CI/CD, and sysadmin work still rely heavily on shell scripts. And Bash understands **POSIX**, a set of standards for how Unix-like systems and their shells should behave, so if you stick to the common subset, your scripts can run under other compatible shells too.
>
> So when we say ‘Bash’ in this course, we mean the language and the environment you get when you open a terminal and run a script with **bash**. That’s the context. Now let’s use it.”

**[PAUSE]** If anyone asks about the “green code rain” or the Matrix: you can mention that the lesson page has a short note linking that look to early terminals and hacker lore; the real story is what you just said.

---

# Module 1: Getting Started (~15 min)

**Goal:** Learners leave knowing what the terminal is, and how to answer “where am I?”, “what’s here?”, and “how do I move?” with **pwd**, **ls**, and **cd**.

---

## 1.1 What is the terminal?

**Say:**

> “The **terminal**—also called the **shell**—is a text-based way to tell the computer what to do. You type a command and press Enter. You can use it to run tools, check logs, and manage files on your machine or on a remote server. No icons, no menus—just a prompt and your keyboard.
>
> Two things to know from the start. First: the **prompt** is the line that appears before your cursor—something like **user@machine:~$**. The system is waiting for your next command. Second: **case matters**. **LS** and **ls** are different. Most commands are lowercase.”

**[DEMO]** Open a terminal. Press Enter a few times. Point out how the prompt just moves down. “You’re in control; the shell only does what you tell it.”

**[PAUSE]** “If you have a terminal open, try pressing Enter a few times. Get used to the prompt.”

---

## 1.2 Where am I? (`pwd`) and what’s here? (`ls`)

**Say:**

> “Your terminal is always ‘in’ a folder. That folder is your **current working directory**. Everything you do—listing files, opening a file—is relative to that folder until you change it.
>
> Two commands you’ll use constantly: **pwd** and **ls**. **pwd** means **P**rint **W**orking **D**irectory. It prints the full path of the folder you’re in. **ls** means **L**i**s**t. It shows the files and folders inside the current directory.”

**[DEMO]**
```bash
pwd
```
> “You might see something like `/Users/jsmith` or `/home/jsmith`—that’s your current directory.”

```bash
ls
```
> “That’s what’s inside it.”

```bash
ls -l
```
> “Same list, but with more detail—sizes, dates, permissions. The **-l** is an option that changes how **ls** behaves. We’ll use **ls -l** again when we talk about permissions.”

**[PAUSE]** “Try **pwd** and **ls** in your terminal. Note the path and the list of files.”

---

## 1.3 Moving around (`cd`)

**Say:**

> “To change which folder you’re in, you use **cd**—**c**hange **d**irectory. **cd** plus a folder name takes you into that folder. **cd** plus two dots—**cd ..**—takes you up one level to the parent. **cd** with nothing, or **cd ~**, takes you to your home directory.”

**[DEMO]**
```bash
cd ~
pwd
```
```bash
cd Desktop
pwd
ls
```
```bash
cd ..
pwd
```
> “So we went home, then into Desktop, then back up one level. **..** always means ‘the parent folder’.”

**[PAUSE]** “Try it: go to your home with **cd ~**, then **cd** into a folder you have—Documents or Desktop—then **cd ..** and confirm you’re back in the parent.”

---

## 1.4 Recap and combined exercise

**[RECAP]** “So far: the terminal is a text interface where you type commands. **pwd** tells you where you are. **ls** tells you what’s here. **cd** moves you; **cd ..** goes up one level.”

**Say:**

> “Let’s do one short exercise that uses all of that. Start from your home directory—**cd ~** and **pwd**. Then **ls** to see what’s there. Pick a folder—say Documents—and run **cd Documents**. Run **pwd** again to confirm you’re inside it. Run **ls** to see its contents. Then run **cd ..** and **pwd** again—you should be back in the parent of Documents. You’ve used the terminal, checked your location, listed contents, and moved. That’s the foundation. Next we’ll work with the files themselves.”

**[PAUSE]** Give them a minute to do the combined exercise. Then move to Module 2.

---

# Module 2: Files and Basics (~15 min)

**Goal:** View files (**cat**, **head**, **tail**), create folders and files (**mkdir**, **touch**), and copy, move, and delete (**cp**, **mv**, **rm**).

---

## 2.1 Viewing file contents

**Say:**

> “Often you need to *look* at a file without opening it in an editor—a config file, a log file. Three commands: **cat** prints the **entire** file. **head** prints the **first** 10 lines by default. **tail** prints the **last** 10 lines. You can change the number: **head -n 5** for the first five lines, **tail -n 20** for the last twenty. The **-n** means ‘number of lines’.”

**[DEMO]** Use a file you have (e.g. in `~/bash-practice` or create one):
```bash
echo "Line one" > test.txt
echo "Line two" >> test.txt
echo "Line three" >> test.txt
cat test.txt
head -n 2 test.txt
tail -n 1 test.txt
```
> “**cat** shows everything. **head -n 2** shows the first two lines. **tail -n 1** shows only the last line—handy for ‘what’s the most recent log entry?’.”

**[PAUSE]** “If you have a text file somewhere, try **cat**, **head -n 3**, and **tail -n 3** on it.”

---

## 2.2 Creating folders and files

**Say:**

> “**mkdir** plus a name creates a new folder—**m**a**k**e **dir**ectory. **touch** plus a filename creates an empty file. If the file already exists, **touch** doesn’t erase it; it just updates the ‘last modified’ time. So **touch** is safe for ‘make sure this file exists’.”

**[DEMO]**
```bash
cd ~
mkdir -p bash-practice
cd bash-practice
touch notes.txt
ls -l notes.txt
touch notes.txt
ls -l notes.txt
```
> “The time might update the second time we **touch** the same file. And **mkdir -p** creates the folder and any parent folders that don’t exist—no error if it’s already there.”

**[PAUSE]** “Create a folder—e.g. **mkdir helpdesk-labs**—then **cd** into it and **touch** two or three files. Then **ls** to confirm.”

---

## 2.3 Copy, move, delete

**Say:**

> “**cp** copies a file: **cp source destination**. The original stays. **mv** moves a file—or renames it, because renaming is just moving to a new name in the same folder. **rm** removes a file. It’s gone; there’s no recycle bin in the shell. So use **rm** carefully. **rm -r** plus a folder name removes that folder and everything inside it—**r**ecursive. Double-check the path before you run **rm -r**.”

**[DEMO]** In `~/bash-practice` or similar:
```bash
cp notes.txt notes-backup.txt
ls
mv notes-backup.txt backup-notes.txt
ls
rm backup-notes.txt
ls
```
> “We copied, then renamed with **mv**, then deleted the copy. The original **notes.txt** is still there.”

**[PAUSE]** “Try copying a file, then renaming the copy with **mv**, then removing only the copy with **rm**.”

---

## 2.4 Recap and combined exercise

**[RECAP]** “**cat** / **head** / **tail** for viewing. **mkdir** and **touch** for creating. **cp** to copy, **mv** to move or rename, **rm** to delete. **rm -r** for a folder and its contents—use with care.”

**Say:**

> “Quick combined exercise: create a **logs** folder, put two lines in a file with **echo ... > app.log** and **echo ... >> app.log**, then **cat** it and **tail -n 1**. Copy it with **cp**, rename the copy with **mv**, then **rm** the original. You’ve viewed files, created them, and used copy, move, and delete. From here on, we’ll do as much as we can from the terminal—no Finder or File Explorer for the rest of the workshop. Next: finding files and searching inside them.”

---

# Module 3: Finding and Filtering (~15 min)

**Goal:** **find** (locate files by name or type), **grep** (search text inside files), **pipes** (chain commands).

---

## 3.1 Finding files with `find`

**Say:**

> “When you don’t know where a file is, **find** searches from a folder downward. You give it a starting folder and criteria. **find . -name "*.txt"** finds everything whose name matches **\*.txt** in the current directory and below. The dot means ‘current directory’. The asterisk is a wildcard—‘anything’. So **\*.txt** means ‘anything ending in .txt’. **-type f** means only files; **-type d** means only directories.”

**[DEMO]**
```bash
cd ~/bash-practice
find . -name "*.txt" -type f
find . -type d -name "logs"
```
> “First: all .txt files under here. Second: any directory named **logs**.”

**[PAUSE]** “Create a couple of .txt files if you don’t have any. Run **find . -name \"*.txt\"** and see the list.”

---

## 3.2 Searching inside files with `grep`

**Say:**

> “**grep** looks for a **text pattern** inside files. You give it the text and the file. It prints every line that contains that text. **grep -n** adds line numbers—handy when you need to say ‘line 42’. **grep -i** ignores case so ‘error’ matches ‘Error’ or ‘ERROR’. **grep -c** just counts how many lines match.”

**[DEMO]** With a small log file:
```bash
echo "INFO start" > sample.log
echo "ERROR something broke" >> sample.log
echo "INFO end" >> sample.log
grep "ERROR" sample.log
grep -n "ERROR" sample.log
grep -c "ERROR" sample.log
```
> “Only the ERROR line is printed; with **-n** you see the line number; with **-c** you get a count.”

**[PAUSE]** “Add a line with the word ERROR to a file and run **grep** and **grep -n** on it.”

---

## 3.3 Pipes

**Say:**

> “A **pipe** is the vertical bar character—**|**. It connects two commands. The **output** of the left command becomes the **input** of the right command. So **command1 | command2** means: run command1, then feed its output to command2. Classic use: list or find something, then filter with **grep**. Or **cat** a file and **grep** it, or **find** and then **head** to limit the number of results.”

**[DEMO]**
```bash
ls -la | grep ".txt"
cat sample.log | grep -i error
find . -type f | head -n 5
```
> “First: list current directory, show only lines containing .txt. Second: contents of the file, only lines with ‘error’ (case ignored). Third: find all files, show only the first five paths.”

**[RECAP]** “**find** for locating by name or type. **grep** for searching inside files; **-n** for line numbers, **-i** for ignore case. **|** pipes output from one command into the next. Next: permissions and who you are.”

---

# Module 4: Permissions and Users (~15 min)

**Goal:** Read **ls -l** (permissions), know who you are (**whoami**, **id**), change permissions with **chmod** when appropriate.

---

## 4.1 Understanding `ls -l`

**Say:**

> “When someone says ‘Permission denied’, it’s usually about file or folder permissions. **ls -l** shows them. You get a line per file. The first character is **-** for a file or **d** for a directory. The next nine characters are permissions in three groups of three: **owner**, **group**, **others**. **r** is read, **w** is write, **x** is execute—or for a directory, permission to enter it. A hyphen means that permission is not granted.
>
> So **-rw-r--r--** means: file; owner can read and write; group and others can only read. **drwxr-xr-x** means: directory; owner can read, write, and enter; group and others can read and enter but not create or delete there. When someone gets Permission denied, they’re usually in the ‘others’ group and the file or directory doesn’t grant them **r** or **x**.”

**[DEMO]**
```bash
ls -l ~
```
> “Pick one file and one directory and read the permission string out loud: file or directory? What can owner, group, others do?”

**[PAUSE]** “Run **ls -l** and find one file with **rw-r--r--** and, if you have one, a script or directory with **x** for the owner.”

---

## 4.2 Who am I? (`whoami` and `id`)

**Say:**

> “Before changing permissions, know **which user** you are. **whoami** prints your username. **id** prints your user id, group id, and group names. When a user reports ‘Permission denied’, asking them to run **whoami**—if they have terminal access—tells you which account is running the command.”

**[DEMO]**
```bash
whoami
id
```
**[PAUSE]** “Run both. Note your username and main group.”

---

## 4.3 Changing permissions with `chmod`

**Say:**

> “**chmod** means **ch**ange **mod**e—permissions. You use it on files or folders you own, or as admin. Don’t relax permissions on sensitive system files. The pattern: **u** is user (owner), **g** is group, **o** is others. **+** adds a permission, **-** removes it. **r**, **w**, **x** as before. So **chmod u+x file** gives the owner execute permission. **chmod o-w file** removes write from others. There’s also a numeric form: **chmod 644 file** is common for files—read and write for owner, read for group and others. **chmod 755 directory** is common for directories—owner can do everything, others can read and enter.”

**[DEMO]** On a file you own (e.g. in `~/bash-practice`):
```bash
touch chmod-demo.txt
ls -l chmod-demo.txt
chmod o-r chmod-demo.txt
ls -l chmod-demo.txt
chmod o+r chmod-demo.txt
chmod 644 chmod-demo.txt
ls -l chmod-demo.txt
```
> “We removed read from others, then put it back, then set the standard 644.”

**[RECAP]** “**ls -l** shows type and permissions. **whoami** and **id** tell you who you are. **chmod** changes permissions—u/g/o, +/-, r/w/x—use carefully. Next: variables and scripts.”

---

# Module 5: Variables and Scripts (~20 min)

**Goal:** **Variables** (store values), **echo** (print and debug), **run a script** (reuse commands safely).

---

## 5.1 Variables

**Say:**

> “In the shell you can store a value in a **variable** so you don’t retype it. You set it with **NAME=value**—no spaces around the equals sign. You use it with **$NAME**—the shell replaces that with the value. You can also store the **output** of a command: **VAR=$(command)**. So **TODAY=$(date +%Y-%m-%d)** puts today’s date in that variable.”

**[DEMO]**
```bash
REPORT=~/bash-practice/report.txt
echo $REPORT
ls $REPORT
TODAY=$(date +%Y-%m-%d)
echo "Today is $TODAY"
```
> “We used a variable for a path and one for command output.”

**[PAUSE]** “Set a variable—e.g. **DIR=~/bash-practice**—then run **ls $DIR** and **echo $DIR**.”

---

## 5.2 `echo` and redirecting to files

**Say:**

> “**echo** prints whatever you give it. Use it for messages or to **debug**—to see what a variable or command produces. **echo \"text\" > file** overwrites the file with that text. **echo \"text\" >> file** appends a line. One arrow overwrites; two arrows append. You’ve seen that with log lines earlier.”

**[DEMO]**
```bash
echo "Step 1 done at $(date)" >> ~/bash-practice/run.log
echo "Step 2 done at $(date)" >> ~/bash-practice/run.log
cat ~/bash-practice/run.log
echo "Fresh start" > ~/bash-practice/run.log
cat ~/bash-practice/run.log
```
> “First we appended two lines. Then we overwrote the file with one line. So **>** replaces the file; **>>** adds to it.”

**[PAUSE]** “Append a line to a file with **echo ... >> file**, then **cat** the file. Then overwrite with **echo ... > file** and **cat** again.”

---

## 5.3 Running a script

**Say:**

> “A **script** is a text file full of commands. The shell runs them one after another. Benefits: repeat the same steps without retyping, share with colleagues, avoid dangerous copy-paste. You create the file with any text editor and save it as something like **myscript.sh**. You run it with **bash myscript.sh**—no need to make it executable. Optionally, the first line can be **#!/bin/bash**—that tells the system to use Bash to run the file. If you make the file executable with **chmod +x myscript.sh**, you can run **./myscript.sh** from that directory.”

**[DEMO]** Create a short script (e.g. `~/bash-practice/status.sh`):
```bash
#!/bin/bash
echo "=== System status ==="
echo "User: $(whoami)"
echo "Date: $(date)"
echo "Directory: $(pwd)"
```
Then:
```bash
bash ~/bash-practice/status.sh
```
> “Three lines printed—user, date, current directory. That’s a script using variables—actually command substitution **$(...)**—and **echo**.”

**[RECAP]** “**VAR=value** to set; **$VAR** to use; **VAR=$(command)** to store command output. **echo** prints and is used with **>** and **>>** for files. Put commands in a **.sh** file and run with **bash script.sh**. Next: we tie everything together in a help-desk scenario.”

---

# Module 6: Help Desk Scenario (~25 min)

**Goal:** One realistic workflow using navigation, files, find, grep, pipes, permissions, and a report script.

**[SETUP]** Before this module (or during a break), run the “engineer setup” below so the practice environment exists. You can do it on your machine and share the screen, or have learners run it in their own **~/bash-practice**.

---

## 6.1 Set up the scenario (engineer / teacher)

**Say:**

> “We’re going to simulate a help-desk request: someone says their machine is slow and they think something is filling the disk; they want us to check for big files and errors in the logs. We’ll do it all from the shell.”

**Run this setup** (or give it to learners to run):

```bash
cd ~
pwd
mkdir -p bash-practice/logs
cd bash-practice
pwd
ls -l

# One log with mixed messages
echo "2024-01-15 09:00 INFO Application started" > logs/app.log
echo "2024-01-15 09:05 ERROR Disk space low" >> logs/app.log
echo "2024-01-15 09:10 INFO Backup started" >> logs/app.log
echo "2024-01-15 09:15 ERROR Timeout connecting" >> logs/app.log

# Another log
echo "2024-01-15 10:00 ERROR Failed to write cache" > logs/system.log
echo "2024-01-15 10:01 INFO Retry succeeded" >> logs/system.log

# A "big" file (small for practice)
dd if=/dev/zero of=bigfile.dat bs=1M count=1 2>/dev/null || echo "large file content here" > bigfile.dat
```

> “We now have a **logs** folder with two log files and a ‘big’ file. On a real machine we’d look for much larger files; here we’re just practicing the commands.”

---

## 6.2 Step 1: Find large files and search for errors

**Say:**

> “First we find files over a certain size—here we’ll use 50 bytes so we actually get results—and we search the logs for the word ERROR. We use **find** and **grep**, and we can pipe things together.”

**[DEMO]**
```bash
find . -maxdepth 2 -type f -size +50c -exec ls -lh {} \;
grep -n "ERROR" logs/*.log
cat logs/*.log | grep -c "ERROR"
```
> “First: find files bigger than 50 bytes, show them with **ls -lh**. Second: every line containing ERROR in any .log file, with line numbers. Third: total count of ERROR lines across all logs.”

**[PAUSE]** “Run the **find** and **grep** commands yourself. See the big file and the ERROR lines.”

---

## 6.3 Step 2: Permissions and user

**Say:**

> “We should note who owns these files and whether they’re readable. **ls -l** and **whoami** / **id** tell us. If we see **-rw-r--r--**, the owner can read and write; others can read. That’s enough for viewing logs and seeing big files.”

**[DEMO]**
```bash
whoami
ls -l logs/
ls -l bigfile.dat
```

---

## 6.4 Step 3: Report script

**Say:**

> “Finally we write a small script that does the same checks and writes a report file. The script should: print who’s running it and write that to the report; list files over 50 bytes and write those paths to the report; print any ERROR lines from the logs and write them to the report; print the total count of ERROR lines and write that; and print where the report was saved.”

**[DEMO]** Create the script (or walk through it line by line). Example:

```bash
#!/bin/bash
# Help desk report: disk check and log errors
REPORTDIR=~/bash-practice
LOGDIR=$REPORTDIR/logs
REPORT=$REPORTDIR/helpdesk-report-$(date +%Y%m%d-%H%M).txt

echo "=== Help desk report $(date) ===" | tee "$REPORT"
echo "User: $(whoami)" | tee -a "$REPORT"
echo "" | tee -a "$REPORT"

echo "--- Larger files (over 50 bytes) ---" | tee -a "$REPORT"
find "$REPORTDIR" -maxdepth 2 -type f -size +50c -exec ls -lh {} \; 2>/dev/null | tee -a "$REPORT"
echo "" | tee -a "$REPORT"

echo "--- ERROR lines in logs ---" | tee -a "$REPORT"
grep -n "ERROR" "$LOGDIR"/*.log 2>/dev/null | tee -a "$REPORT"
echo "" | tee -a "$REPORT"

ERROR_COUNT=$(cat "$LOGDIR"/*.log 2>/dev/null | grep -c "ERROR" || echo "0")
echo "Total ERROR lines: $ERROR_COUNT" | tee -a "$REPORT"

echo "" | tee -a "$REPORT"
echo "Report saved to: $REPORT"
```

> “**tee** both prints to the screen and appends to the file. We use variables for paths, **find** and **grep** and pipes, and we write everything into a timestamped report file.”

Run it:
```bash
bash ~/bash-practice/helpdesk-report.sh
cat ~/bash-practice/helpdesk-report-*.txt
```

**[PAUSE]** “Try running the script. Then **cat** the report file it creates.”

---

## 6.5 Summary and close

**[RECAP]** “In this scenario we used **pwd**, **ls**, **cd**, **mkdir**; **echo**, **cat**, **find**, **grep**, pipes; **whoami**, **ls -l**; and a script with variables, **tee**, and the same commands. On a real machine you’d point the script at real log directories and use larger size thresholds. The ideas are the same.”

**Say:**

> “That’s the basics track. You’ve seen navigation, files, finding and filtering, permissions, variables, echo, and scripting—and we tied it together in one help-desk-style workflow. Keep a quick reference handy when you’re on the command line, and re-run this scenario or parts of it until it feels familiar. If you’re doing the challenges, you’ll get more practice with each of these ideas. Any questions?”

**[PAUSE]** Open for questions. Point them to the REFEREE-SITE challenges and any next steps (e.g. intermediates, advanced).

---

*End of Basics Teaching Script*
