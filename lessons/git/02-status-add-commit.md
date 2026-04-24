# Git 2: Status, add, and commit

**Concepts:** **Working directory**, **staging**, **commit**, **`git status`**, **`git add`**, **`git commit`**, **`git log`**.

---

## The basic loop

1. Edit files in your project (working directory).
2. **Stage** changes you want in the next snapshot: `git add`.
3. **Commit** — save that snapshot with a message: `git commit`.

---

## `git status`

Shows which files are **modified**, **staged**, or **untracked**.

```bash
git status
```

Use it often — it tells you what Git sees before you commit.

---

## `git add`

Stages files (prepares them for the next commit).

| Command | Effect |
|---------|--------|
| `git add file.txt` | Stage one file |
| `git add .` | Stage all changes in the current directory (use carefully) |
| `git add -p` | Interactively choose hunks to stage |

---

## `git commit`

Creates a commit from what is staged.

```bash
git commit -m "Short description of the change"
```

Good commit messages explain **why** the change was made, not only what. A good format for commit messages is "TYPE: description" where TYPE is the type of commit your adding, for instance a bug fix would be "BUGFIX: " or "FIX: ", whereas a new sfeature would be "FEATURE: "

---

## `git log`

Lists commits (newest first).

```bash
git log
git log --oneline   # one line per commit
```

Press `q` to leave the pager when viewing full log.

---

## Recap

- **status** → what changed  
- **add** → stage  
- **commit** → snapshot with message  
- **log** → history  

Next: [03 – History and diff](03-history-and-diff.md)

---
