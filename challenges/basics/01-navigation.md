# Challenge 1: The Labyrinth

**Module:** 1 – Getting started  
**Skills:** `pwd`, `ls`, `cd`

---

## Mission

A **code** is hidden in the **deepest folder** of a maze under `~/bash_ctf/basics/module1`. There are dead ends and one path that leads to a file named `code.txt`. Use only navigation: list directories and change into them until you find it.

---

## Steps

1. Go to the challenge root: `cd ~/bash_ctf/basics/module1`
2. Use `ls` and `cd` to explore. When you reach a dead end, use `cd ..` to go back and try another branch.
3. When you find `code.txt`, run `cat code.txt` to see the code.

---

## Success

You’ve completed the challenge when you see the code. Submit that exact string in the input for Basics: 01 - Navigation.

---

## Hints

<details>
<summary>Click to show hints</summary>
<ul>
<li>The path to the code has multiple levels; folder names are not numbered—explore with <code>ls</code>.</li>
<li><code>cd ..</code> takes you back to the parent directory.</li>
<li>Use <code>ls</code> after every <code>cd</code> so you don’t miss the branch that leads to <code>code.txt</code>.</li>
</ul>

</details>
