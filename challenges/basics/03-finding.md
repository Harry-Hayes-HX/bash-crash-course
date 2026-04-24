# Challenge 3: Needle in the Haystack

**Module:** 3 – Finding and filtering  
**Skills:** `find`, `grep`, pipes `|`

---

## Mission

Under `~/bash_ctf/basics/module3` there are many log files, including in **subdirectories**. One of them contains a line with `LOG_REF:` followed by the real code (some files may mention LOG_REF differently). Find that file and that line using `find` and/or `grep`.

---

## Steps

1. Go to the module: `cd ~/bash_ctf/basics/module3`
2. Search the `logs` tree (including subdirs) for the line that contains `LOG_REF:` and the real code. Submit that **full line**.

---

## Success

You’ve completed the challenge when you see the line full line. Submit that exact string in the input for Basics: 03 - Finding.

---

## Hints
<details>
<summary>Click to show hints</summary>
<ul>
<li><code>grep -r "LOG_REF" module3/logs</code> searches all files under <code>logs/</code> recursively.</li>
<li><code>find module3 -name "*.log"</code> lists log files; you can combine with <code>grep</code> or <code>xargs</code>.</li>
<li>More than one line may mention LOG_REF; the one you need contains the actual code (letters and numbers after <code>LOG_REF:</code>).</li>
</ul>

</details>