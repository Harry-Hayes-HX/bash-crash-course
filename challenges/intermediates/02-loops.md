# Challenge 2: Assembly Line

**Lesson:** 2 – Loops  
**Skills:** `for` loop over files; concatenating output

---

## Mission

The **assembly code** in `~/bash_ctf/intermediates/module2/` is split so **each file holds one character**: **code.01**, **code.02**, **code.03**, … up to **code.20**. Concatenate them **in numerical order** (01, 02, 03, …) to form one line—the code. You must use a **for** loop over the files (e.g. use `sort -V` to get the right order).

---

## Steps

1. Go to the challenge folder:
   ```
   cd ~/bash_ctf/intermediates/module2
   ```
   ```
   ls
   ```
2. Inspect a few files (e.g. `cat code.01`, `cat code.02`). Each contains a single character.
3. Reassemble the assembly code: each file code.01, code.02, ... holds one character. Use a for loop over the files in order.

---

## Success

You’ve completed the challenge when the concatenated output is the "assembly" code. Submit that exact string in the input for Intermediate 02 - Assembly Line.

---

## Hints
<details>
<summary>Click to show hints</summary>
<ul>
<li>Files are named <code>code.01, code.02, … code.20</code>. Use <code>sort -V</code> (version sort) so they stay in numerical order when you loop.</li>
<li>Each file was created with <code>printf</code> (one character, no newline), so the loop output is one continuous line.</li>
<li>Write a <b>for</b> loop that concatenates them in order. Use sorted names so order is correct.
<details>
<summary>Click to see solutions</summary>
<ul>
<li><code>for f in $(ls code.* | sort -V); do cat "$f"; done</code></li>
<li>Or list them explicitly by number:
<ul>
<li><code>for i in $(seq -w 1 20); do cat "code.$i"; done</code></li>
<li>On some systems <code>seq -w 1 20</code> gives 01, 02, …; if not, use a loop with <code>printf '%02d'</code>.</li>
</ul>
</li>
<li>Optionally redirect to a file and cat it:
<ul>
<li><code>for f in $(ls code.* | sort -V); do cat "$f"; done > full.txt; cat full.txt</code></li>
</ul>
</li>
</ul>
</li>
</ul>
</details>