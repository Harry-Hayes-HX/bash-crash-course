# Challenge 5: Log Hunter (Capstone)

**Lesson:** 5 – Capstone script  
**Skills:** Arguments, functions, loops, conditionals, exit codes

---

## Mission

**What you need:** A path to search. Run **./hint.sh** in the capstone folder—it prints the path. That same path will be passed to your script when you run it via run_me.

**What your script must do:** Search under that path for a log file that contains a line with **REPORT_ID**. One of the directories under the path has it in **log.txt**. Your script must **exit 0** if it finds the report ID, **exit 1** if not.

**How you get the code:** Run **./run_me.sh &lt;your_script&gt;**. run_me.sh will call hint.sh to get the path, run your script with that path as its first argument, and—if your script exits 0—print the report ID.

---

## Steps

1. Go to the challenge folder:
   ```
   cd ~/bash_ctf/intermediates/module5
   ```
   ```
   ls
   ```
2. See how run_me and hint work: run `./hint.sh` (it prints the path run_me will pass to your script).
3. Write your script
4. Run it:
   ```
   chmod +x find_flag.sh
   ```
   ```
   ./run_me.sh ./find_flag.sh
   ```
   If your script exits 0, run_me prints the report ID.

---

## Success

You’ve completed the challenge when run_me.sh prints the report ID. Submit that exact string in the input for Intermediate 05 - Capstone.

---

## Hints

<details>
<summary>Click to show hints</summary>
<ul>
<li>Your script should:</li>
<ul><li>- Take <code>$1</code> as the directory to search (the path hint.sh outputs).</li>
<li>- Define a <code>function</code> that takes a file path and returns 0 if that file contains “REPORT_ID” (e.g. <code>grep -q REPORT_ID "$1"; return $?</code>).</li>
<li>- <code>Loops</code> over <code>"$1"/dir_*/log.txt</code> (or equivalent).</li>
<li>- Uses a <b>conditional</b>: if the function returns 0 for a file, print the matching line (or the path) and <code>exit 0</code>.</li>
<li>- After the loop, <code>exit 1</code> (report not found).</li>
<li>- <code>hint.sh</code> just prints the path to the capstone directory; run_me passes that as $1 to your script.</li>
<li>- Your function can be: <code>contains_report_id() { grep -q REPORT_ID "$1"; return $?; }</code>. Call it with the path to each log file.</li>
<li>- Loop with: <code>for f in "$1"/dir_*/log.txt; do ... done</code>. Use <code>"$1"</code> so paths with spaces work.</li>
<li>After the loop, if you never exited 0, run <code>exit 1</code>.</li>
<details><summary>Click to show full solution</summary><pre>#!/bin/bash
root="${1:?Usage: $0 &lt;path-to-capstone-dir&gt;}"

contains_report_id() {
  grep -q "REPORT_ID" "$1"
  return $?
}

for f in "$root"/dir_*/log.txt; do
  [ -f "$f" ] || continue
  if contains_report_id "$f"; then
    exit 0
  fi
done
exit 1
</pre>
Save the script as e.g. find_flag.sh, then run:
<pre>
cd ~/bash_ctf/intermediates/module5
chmod +x find_flag.sh
./run_me.sh ./find_flag.sh
</pre>

If your script exits 0, run_me.sh prints the report ID.</details>
</li>
</ul></ul>
</details>
