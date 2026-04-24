# Challenge 2: Lost Memo

**Module:** 2 – Files and basics  
**Skills:** `cat`, redirecting output with `>`, optionally `cp` / `mv`

---

## Mission

A memo was split into **three parts** (<code>memo.part1</code>, <code>memo.part2</code>, <code>memo.part3</code>) in `~/bash_ctf/basics/module2/inbox/`. The inbox also has decoy files. Your job: concatenate the three parts **in order** so the full memo ID appears on one line.

---

## Steps

1. Go to the inbox: `cd ~/bash_ctf/basics/module2/inbox` and list files.
2. Concatenate memo.part1, memo.part2, and memo.part3 in that order (e.g. with <code>cat</code>) so the output is a single line: the memo ID.


---

## Success

You’ve completed the challenge when you see the full line. Submit that exact string in the input for Basics: 02 - Files.

---

## Hints

<details>
<summary>Click to show hints</summary>
<ul>
<li>Only <code>memo.part1</code>, <code>memo.part2</code>, and <code>memo.part3</code> form the memo; order matters (1, 2, 3).</li>
<li><code>cat file1 file2 file3</code> prints the three files one after another. Use that to get the memo ID on one line. You can redirect with <code>&gt; out.txt</code> if you want to save it.</li>
<li>Ignore decoys (e.g. <code>junk.txt</code>, <code>notes.txt</code>).</li>
</ul>

</details>