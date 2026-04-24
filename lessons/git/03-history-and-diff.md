# Git 3: History and diff

**Concepts:** **`git diff`**, **`git show`**, **discarding local changes** (careful).

---

## `git diff`

Shows **unstaged** changes (working tree vs last commit).

```bash
git diff              # unstaged changes
git diff --staged     # staged changes (what will go in next commit)
```

---

## `git show`

Shows one commit: message, author, date, and patch.

```bash
git show           # latest commit
git show abc1234   # specific commit (use part of the hash from git log)
```

---

## Undoing things (local only)

| Goal | Command |
|------|---------|
| Unstage a file (keep edits) | `git restore --staged file` or `git reset HEAD file` |
| Discard edits in working copy | `git restore file` — **destroys uncommitted changes** |

Always confirm with `git status` before destructive commands.

---

## Recap

- **diff** — see what changed before committing.  
- **show** — inspect a single commit.  
- **restore** — unstage or discard (use with care).  

Next: [04 – Branching](04-branching.md)

---
