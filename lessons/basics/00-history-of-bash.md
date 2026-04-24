# A Short History of Bash

**Concepts:** Where Bash came from, why it’s called “Bash,” and why it still matters.

---

Before we dive into commands and scripts, a quick look at where the shell you’re using came from—and why that green-on-black “hacker” look in the movies isn’t so far from real terminal history.

<div id="matrix-rain-canvas" class="matrix-rain-container" aria-hidden="true"></div>

*That “digital rain” look—lines of code and symbols—was inspired by the kind of output you’d see on early terminals and in hacker lore. The real story is a bit more grounded.*

---

## Unix and the first shells

In the late 1960s and early 1970s, **Unix** was developed at Bell Labs. Unix is a family of multitasking, multi-user operating systems (the programs that run the computer and let many people use it at once, doing several jobs at a time.) Users needed a way to type commands and run programs. That program — the **shell** — read your input and started other programs.

| Shell | Year | Notes |
|-------|------|--------|
| **Thompson shell** | 1971 | First Unix shell. Simple; no real scripting. |
| **Bourne shell** (**sh**) | 1977 | By **Stephen Bourne**. Variables, control flow, scripts. It became the standard for Unix and later **POSIX**. |

Many systems still ship a `sh` that is either the original Bourne shell or a compatible one.

---

## Bash: “Bourne Again Shell”

**Bash** (**B**ourne **A**gain **SH**ell) was written for the **GNU Project** in **1989** by **Brian Fox**. The goal was a free, feature-rich shell that behaved like the Bourne shell but added better interactivity and scripting: command history, editing, arrays, and more.

- **1989** — First release (version 0.99).
- **1990s–today** — Default login shell on most Linux distros and on macOS for a long time (Apple switched the default to zsh in Catalina; Bash is still installed). When people say “shell script” on Linux—and often on Mac—they usually mean Bash.

---

## Why it still matters

- **Everywhere** — Bash (or a similar `sh`) is on almost every Linux server, most Macs, and in tools like Git Bash on Windows. Scripts you write in Bash can run in a lot of places.
- **Automation** — Servers, CI/CD, and sysadmin work still rely heavily on shell scripts. Knowing Bash helps you read, write, and debug them.
- **POSIX and portability** — **POSIX** (Portable Operating System Interface) is a set of standards that define how Unix-like systems (and their shells, tools, and APIs) should behave. Bash understands **POSIX** sh, so if you stick to the common subset, your scripts can run under other sh-compatible shells and on different systems too.

So when we say “Bash” in this course, we mean the language and the environment you get when you open a terminal and run a script with `bash` (or when your system uses Bash as the default shell). 


You’ve learnt about the history of BASH, now move onto: [01 - Getting Started](01-getting-started.md).

---
