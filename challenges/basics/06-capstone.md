# Challenge 6: Help Desk Hero

**Module:** 6 – Full scenario  
**Skills:** Navigation, `grep`, `find`, permissions, reading files

---

## Mission

You’re responding to a “system error” report. Several logs in `module6/logs/` contain ERROR lines. More than one may mention a “report” or “archive”—only one gives the **path to the critical report** you need. Find that message, go to the path (including the date subfolder), fix the permission on the report file, and read it to get the report ID.

---

## Steps

1. **Start in the module:**
   ```bash
   cd ~/bash_ctf/basics/module6
   ```

2. **Find the right error.** There are multiple log files and multiple ERROR lines. One of them mentions where the report was written (a path under this module). Note the **full path**.

3. **Navigate to that path.** Use `cd` and `ls` to reach the directory that contains the report file. There may be decoy files; (hint: the one you need is the filename in the error message).

4. **Fix permissions.** You might not be able to read the file.... wonder why that is?

5. **Submit the report ID** you see inside.

---

## Success

You’ve completed the challenge when you see the report ID flag. Submit that exact string in the input for Basics: 06 - Capstone.

---

## Hints

<details>
<summary>Click to show hints</summary>

<ul>
<li>Not every ERROR that mentions "report" or "archive" is the right one; use the message that gives the exact path (folder and date) and filename.</li>
<li>The path has a top-level folder and a date subfolder (YYYY-MM-DD). Use <code>ls</code> and <code>cd</code> to reach the directory that contains the report file.</li>
<li>The report filename appears in that same ERROR message. Ignore decoy files in that directory.</li>
<li><code>reports/hint.txt</code> gives a vague pointer if you are stuck.</li>
</ul>
</details>
