# Module 1: Getting Started

**Concepts:** What the terminal is, **pwd** (**P**rint **W**orking **D**irectory - where am I?), **ls** (**L**i**s**t - what’s here?), **cd** (**c**hange **d**irectory).

---

## Concept 1: What is the terminal?

The **terminal** (or **shell**) is a text-based way to tell the computer what to do. You type commands and press Enter. you can use it to run tools, check logs, and manage files on your own machine or a remote server.

- **Prompt:** The line that appears before your cursor (e.g. `user@machine:~$`). It’s waiting for your next command.
- **Case matters:** `LS` and `ls` are different. Most commands are lowercase.

**Small example:** Open a terminal and press Enter a few times. Notice the prompt just moves down.

---

## Concept 2: Where am I? (`pwd`) and what’s here? (`ls`)

Your terminal is always “in” a folder (directory). That’s your **current working directory**.

| Command | What it does |
|--------|----------------|
| **pwd** | **P**rint **W**orking **D**irectory — shows the full path of the folder you’re in |
| **ls**  | **L**i**S**t — shows files and folders inside the current directory |

**Small examples:**

![Screenshot: running pwd](/static/images/lessons/basics/01-getting-started/01-pwd.png)

*Example: terminal with `pwd` typed and the path it prints.*

![Screenshot: running ls](/static/images/lessons/basics/01-getting-started/01-ls.png)

*Example: terminal with `ls` and the list of files and folders.*


![Screenshot: running ls -la](/static/images/lessons/basics/01-getting-started/01-ls-la.png)

*Example: terminal with `ls -la` and a detailed list of all files, including hidden files(sizes, dates, permissions).*

---

## Concept 3: Moving around (`cd`)

**cd** = **c**hange **d**irectory. You “go” into another folder.

| Command        | What it does |
|----------------|--------------|
| `cd foldername` | Go into the folder named `foldername` |
| `cd ..`         | Go up one folder (parent directory) |
| `cd` or `cd ~`  | Go to your home directory |

**Small examples:**

![Screenshot: running cd {foldername}](/static/images/lessons/basics/01-getting-started/01-cd-FolderName.png)

*Example: terminal with cd command*

![Screenshot: running cd ..](/static/images/lessons/basics/01-getting-started/01-cd-Up-1.png)

*Example: terminal with cd .. command*

![Screenshot: running cd/cd ~](/static/images/lessons/basics/01-getting-started/01-cd-Home-Folder.png)

*Example: terminal with cd ~ command*

---

## Concept 4: What is `sudo`?

**`sudo`** (**S**uper**U**ser **DO**) means "run this command as the **superuser** (administrator)." It's used when a command needs extra privileges (e.g. installing software or changing ownership of files). You may be asked for your password.

**What is the sudoers file?** The system keeps a list of who is allowed to run commands as superuser in a config file (on Linux this is usually `/etc/sudoers`). Only users or groups listed there (or in files under `/etc/sudoers.d/`) can use `sudo`. If you're not in that list, you'll see an error like "user is not in the sudoers file."

**Who can use sudo?** Only users who have been granted permission by the system. On your own personal machine, your account is often in the sudoers list (or the *wheel* / *admin* group), so you can use it. For HX staff, we can open **Mosyle's Self Service** app and use **Admin on Demand** to temporarily add your account to the sudoers list so you can run the setup scripts; when the session ends, your sudo access is removed again. On a shared server or locked-down machine without that option, you'd need an administrator to run the setup for you or add your account.

- **When to use sudo:** Run the challenge **setup scripts** with sudo (e.g. `sudo bash setup/setup-challenges-basics.sh`). That lets the setup create the right file ownership and permissions for the exercises.
- **When you can use sudo in challenges:** You may use sudo when a challenge explicitly requires it (e.g. the permissions challenge may require `sudo chown` to take ownership of a file). Otherwise, solve challenges using normal user commands.

---

## Recap:

- **1:** Terminal = text interface; you type commands.
- **2:** `pwd` = where am I? 
- **3:** `ls` = what’s here?
- **4:** `cd` = change directory; `cd ..` = go up one level.
- **5:** `sudo` = run as admin; use for setup scripts and when a challenge requires it (e.g. `sudo chown` in the permissions challenge).

---

## Example 1 — Focus on 1 (terminal and typing)

1. Open the terminal.
2. Run some commands, explore your computer, see what directory you're in, and what files it contains.
3. Have some fun

---

## Example 2 — Focus on 2 (`pwd` and `ls`)

1. Run `pwd` and note the path.
2. Change your directory to somewhere else (cd ../cd ~)
3. Run `pwd` again. See how the path in the output from the command has changed?

---

## Example 3 — Focus on 3 (`cd`)

1. Run `cd ~` then `pwd` (you should be in your home directory).
2. Run `cd Desktop` (or `cd Documents` if you prefer), then `pwd`.
3. Run `cd ..` then `pwd` — you should be back in the parent folder.

---

## Combined example — 1 + 2 + 3

**Goal:** Navigate from your home folder into a subfolder, list its contents, then go back up and confirm where you are.

1. Start from home: `cd ~` then `pwd`.
2. List what’s there: `ls`.
3. Pick a folder (e.g. `Documents`) and enter it: `cd Documents` (or the name you chose).
4. Run `pwd` — confirm you’re inside that folder.
5. Run `ls` — see what’s inside.
6. Go up one level: `cd ..`.
7. Run `pwd` again — you should be back in the parent of `Documents`.

You’ve used the terminal, checked your location (`pwd`), listed the directories contents (`ls`), and moved to a new directory (`cd`). Next Up: Files and Basics!

You’ve gotten started, now move onto: [02 - Files and Basics](02-files-and-basics.md).

---