# Challenge 3: Arrays, the Universe, and Everything

**Lesson:** 3 – Arrays and data  
**Skills:** `mapfile`, array index

---

## Mission

Go to **~/bash_ctf/advanceds/arrays** and look at **list.txt**. I've lost the flag in there and I can't remember what index it's at. Find it.

---

## Steps

1. `cd ~/bash_ctf/advanceds/arrays`


---

## Success

You’ve completed the challenge when your script prints code. Submit that exact string in the input for Advanced: 03 - Arrays

## Hints
<details>
<summary>Click to show hints</summary>
<ul>
<li>- The file has many lines; you need one line by its position (index). Bash can read a file line-by-line into an array.</li>
<li>- <b>mapfile</b> (or <b>readarray</b>) reads lines from a file into an array. Then use <code>${arr[INDEX]}</code> to get the line at that index.</li>
<li>- Remember, most indexes are 0 based (line 1 in the file is index 0)</li>
<li>- Look around the same folder — another file might hint at which index to use.</li>

<details>
<summary>Full solution</summary>
<pre>
#!/bin/bash
cd "$(dirname "$0")"
mapfile -t arr < list.txt
echo "${arr[542]}"
</pre>
</details>
</ul>
</details>
