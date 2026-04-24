# Git 5: Remote, clone, push, and pull

**Concepts:** **Remote**, **`git clone`**, **`git push`**, **`git pull`**, **`origin`**.

---

## Remote

A **remote** is a named URL to another copy of the repo (usually on GitHub/GitLab). The default name is **`origin`**.

```bash
git remote -v    # list remotes and URLs
```

---

## Clone

Copy a repo from a server to your machine (full history).

```bash
git clone https://github.com/user/repo.git
cd repo
```

---

## Branch protection (no direct push to `main`)

Many teams use **branch protection** on the hosting site (GitHub, GitLab, etc.): **you cannot push straight to `main`**. Pushes to `main` are rejected so that all changes go through review (e.g. a **pull request** / **merge request**) and checks can run first.

If `git push origin main` fails with a permission or “protected branch” error, that is expected. Instead:

1. Create a branch: `git switch -c my-feature`
2. Commit your work on that branch.
3. Push the branch: `git push -u origin my-feature`
4. Open a PR to merge into `main` on the website.

You can still **`git pull origin main`** to update your local `main` from the remote.

---

## Push and pull

After you commit on a **feature branch** (typical when `main` is protected):

```bash
git push -u origin my-feature   # push your branch (not main)
```

On a small personal repo without protection, you might push `main` directly:

```bash
git push origin main    # only when the remote allows it
```

Get others’ changes:

```bash
git pull origin main    # fetch + merge (or use fetch + merge separately)
```

First time pushing a new branch:

```bash
git push -u origin feature   # sets upstream so later you can use git push
```

---

## Typical workflow (protected `main`)

1. `git clone` …  
2. `git pull origin main` before starting work.  
3. `git switch -c feature/short-name`, commit, `git push -u origin feature/short-name`.  
4. Open a **pull request** into `main`; after approval, merge on the site (you don’t push to `main` yourself).

---

## Recap

- **Branch protection** — often blocks `git push` to `main`; use a feature branch + PR instead.  
- **clone** — copy repo down.  
- **push** — send your **branch** up (not always `main`).  
- **pull** — bring remote changes in.  
- **origin** — default remote name.  

You’ve finished the short Git lesson track. Practice on a test repo; there are no CTF flags for these lessons.

---
