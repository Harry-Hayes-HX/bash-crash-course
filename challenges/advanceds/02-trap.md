# Challenge 2: Clean Exit

**Lesson:** 2 – trap and signals  
**Skills:** `trap` on EXIT

---

## Mission

In `~/bash_ctf/advanceds/trap/` you run your script via **./run_me.sh &lt;your_script&gt;**; the runner passes this directory as **$1**, then stops your script after a moment. While your script is running, **code.txt is not present** in the directory—the runner only puts it there when it stops your script. Get the secret code.

---

## Rules

- The **only command you may run manually** is the one that invokes the runner, e.g. **./run_me.sh ./your_script.sh**. Everything else must be in the script you write.

---

## Success

You've completed the challenge when the code is printed. Submit that exact string in the input for Advanced: 02 - Clean Exit

---

## Hints
<details>
<summary>Click to show hints</summary>

- You need something that runs <b>when the script exits</b>, not during normal execution.
- Bash can run a command (or a list of commands) when the script exits — look for <b>trap</b> and the <b>EXIT</b> signal.
- The runner passes the trap directory as <code>$1</code>; when your script is stopped, the file <code>code.txt</code> will exist in that directory.

<details>
<summary>Full solution</summary>
<pre>
#!/bin/bash
trap 'cat "$1/code.txt"' EXIT
sleep 999
</pre>
</details>
</details>
