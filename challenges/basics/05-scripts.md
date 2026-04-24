# Challenge 5: Secret Path

**Module:** 5 – Variables and scripts  
**Skills:** Variables, **export**, reading from a file, running a command with a variable set

---

## Mission

In `~/bash_ctf/basics/module5/` there is a script **run_me.sh** and a file **path.txt** (containing a random key). The script **only prints the token** when you run it with **SECRET_PATH** set to exactly that key. The token is **not** stored in any file you can `cat` — only the script can output it. So the only way to get the token is to read the key from path.txt into **SECRET_PATH** and run the script.

---

## Steps

1. Go to the module: `cd ~/bash_ctf/basics/module5`
2. Run `./run_me.sh` without setting SECRET_PATH — it will tell you what to do. The key you need is in path.txt.
3. Read path.txt into SECRET_PATH and run the script with it set so it prints the token.

---

## Success

You've completed the challenge when you see the path token (the line starting with `PATH_TOKEN:`). Submit that exact string in the input for Basics: 05 - Scripts.

---

## Hints

<details>
<summary>Click to show hints</summary>

<ul>
<li>To run a command with a variable set for that one run: <code>VAR=value ./script.sh</code>. The script sees <code>$VAR</code>.</li>
<li>Alternatively, use <code>export VAR=value</code> (or <code>export VAR</code> after setting VAR), then run <code>./script.sh</code> — the script will see the exported variable.</li>
<li>To set VAR to the contents of a file: <code>VAR=$(cat path.txt)</code>. Then either <code>export VAR</code> and <code>./run_me.sh</code>, or <code>VAR=$(cat path.txt) ./run_me.sh</code>.</li>
<details>
<summary>Click to show solution</summary>
<li>So:</li>
<ul><li><code>cat path.txt</code></li>
<li><code>SECRET_PATH={output from previous command}</code></li>
<li><code>./run_me.sh</code></li></ul>
</ul>

</details>
