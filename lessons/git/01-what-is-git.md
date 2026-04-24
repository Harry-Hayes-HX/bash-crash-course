# Git 1: What is Git?

**Concepts:** **Version control**, **repository**, **why Git** (no CTF challenges for this track — read and practice on your own).

---

## What is version control?

**Version control** keeps a history of changes to files over time. You can see what changed, when, and by whom; go back to an older version; and work on branches without losing work.

**Git** is the most widely used version control system. It runs on your machine and can sync with hosting sites like GitHub, GitLab, or Bitbucket.

---

## What is a repository?

A **repository** (or **repo**) is a folder Git is tracking. Inside it, Git stores:

- **Commits** — snapshots of your project at points in time.
- **History** — who changed what and when.
- **Branches** — parallel lines of work (e.g. a feature branch).

You **initialize** a repo with `git init` or **clone** an existing one with `git clone`.

---

## Why learn Git?

- Collaborate without emailing zip files.
- Undo mistakes safely.
- Review changes before sharing.
- Industry standard for software and many other teams.

---

## Install Git

- **macOS:** Often pre-installed, or install Xcode Command Line Tools: `xcode-select --install`
- **Windows:** [git-scm.com](https://git-scm.com/) installer
- **Linux:** `sudo apt install git` (Debian/Ubuntu) or your distro’s package manager

Check: `git --version`

---

## Recap

- **Version control** = history of changes.
- **Git** = tool; **repository** = tracked project folder.
- Next: [02 – Status, add, and commit](02-status-add-commit.md)

---
