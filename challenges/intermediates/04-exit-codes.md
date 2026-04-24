# Challenge 4: Unlock

**Lesson:** 4 – Exit codes and robustness  
**Skills:** Writing a script that uses **$?** and **exit** so another script only rewards success

---

## Mission

**run_me.sh** in `~/bash_ctf/intermediates/module4/` takes one argument: a path to *your* script. It runs your script and **only prints the success code if your script exits 0**. You must **write a script** that runs a command that succeeds and then **exits with that command’s exit code**

---

## Steps

1. Go to the challenge folder:
   ```
   cd ~/bash_ctf/intermediates/module4
   ```
   ```
   ls
   ```
2. **Write a script** (e.g. `my_script.sh`) that:
   - Runs a command that exits 0,
   - Then exits with that command’s exit code.
3. Run run_me with your script:
   ```
   ./run_me.sh ./my_script.sh
   ```
   run_me will print the success code when your script exits 0.

---

## Success

You’ve completed the challenge when run_me.sh prints the success code. Submit that exact string in the input for Intermediate 04 - Unlock.

---

## Hints

<details>
<summary>Click to show hints</summary>
<ul>
<li>- After any command, <b><code>$?</code></b> holds its exit code. So <b><code>true; exit $?</code></b> makes your script exit 0.</li>
<li>- Your script can run any command that succeeds <code>(exit 0);</code> the point is to use <b><code>exit $?</code></b> so <code>run_me.sh</code> sees that success.</li>
</ul>
</details>