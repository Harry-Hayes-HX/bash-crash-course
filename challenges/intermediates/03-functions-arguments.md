# Challenge 3: Two Keys

**Lesson:** 3 – Functions and arguments  
**Skills:** Script arguments; capturing command output in variables and passing as arguments

---

## Mission

A script in `~/bash_ctf/intermediates/module3/` prints the unlock code only when given **two correct arguments** that **get_keys.sh** has just produced. The keys are **different every time** you run get_keys.sh, and they **expire after a few seconds**. So you must run **get_keys.sh** and pass its output to **unlock.sh** in the **same command** (e.g. command substitution). If you run get_keys.sh, then run unlock.sh separately with the keys you saw, the keys will already be expired or overwritten.

---

## Steps

1. Go to the challenge folder:
   ```
   cd ~/bash_ctf/intermediates/module3
   ```
   ```
   ls
   ```
   ```
   cat README.txt
   ```
2. Run `get_keys.sh` a couple of times: you’ll see the two keys change every run. Unlock only accepts keys that were produced recently, so you must run `get_keys.sh` and `unlock.sh` in the same command.
3. The script should print the unlock code. If you see `Keys wrong or expired`, you ran `unlock.sh` too long after `get_keys.sh` — try capturing the `get_keys.sh` output, and passing it into `unlock.sh` as an argument.

---

## Success

You’ve completed the challenge when you see the unlock code. Submit that exact string in the input for Intermediate 03 - Two Keys.

---

## Hints

<details>
<summary>Click to show hints</summary>
<ul>
<li>Remember you can use command substitution<b><code>$(./path/to/script.sh)</code></b> to run a script and assign its output to a variable.</li>
<li>Keys are time-limited; don’t run <code>get_keys.sh</code>, then run <code>unlock.sh</code> in a separate command — do it in one go.</li>
<li>The script checks that the two arguments match the keys that <code>get_keys.sh</code> last wrote (and that they’re not older than a few seconds).</li>
</ul>
<ul><li>Use command substitution so <code>get_keys.sh</code> runs and its output is passed straight to <code>unlock.sh</code>.</li></ul>
<details>
<summary>Click to show solution</summary>
<ul><li><code>./unlock.sh $(./get_keys.sh)</code></li>
<ul><li>Your essentially running<code>unlock.sh</code> with the output of<code>get_keys</code> as the args passed to <code>unlock.sh</code></li></ul></ul>
</details>