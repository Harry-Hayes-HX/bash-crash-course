# Git 4: Branching

**Concepts:** **Branch**, **`git branch`**, **`git switch`** / **`git checkout`**, **merge**.

---

## Why branches?

A **branch** is a movable pointer to a commit. The default branch is often called **`main`** or **`master`**.

Branches let you:

- Work on a feature without affecting stable code.
- Experiment safely.
- Review changes before merging into the main line.

---

## Create and switch

```bash
git branch              # list branches
git switch -c feature   # create branch "feature" and switch to it
# Older syntax (still common):
git checkout -b feature
```

```bash
git switch main         # go back to main
```

---

## Merge

Bring another branch’s commits into your current branch.

```bash
git switch main
git merge feature
```

If there are no conflicts, Git creates a **merge commit** (or fast-forwards). If two branches edited the same lines, you get a **merge conflict** to resolve manually.

---

## Recap

- **branch** — parallel line of work.  
- **switch** / **checkout** — change branch.  
- **merge** — combine branch into current branch.  

Next: [05 – Remote, clone, push, and pull](05-remote-clone-push.md)

---
